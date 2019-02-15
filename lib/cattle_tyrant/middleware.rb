# frozen_string_literal: true

module CattleTyrant
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call env

      if headers && headers['Content-Type']&.include?('text/html') &&
         (status / 100 != 3) && # redirections
         (!env['action_dispatch.content_security_policy']&.script_src('unsafe-inline') && !env['action_dispatch.content_security_policy']&.style_src('unsafe-inline')) # the Rails default top page has this
        case body
        when ActionDispatch::Response, ActionDispatch::Response::RackBody
          body = body.body
        when Array
          body = body[0]
        end

        body = body.dup if body.frozen?
        body.sub!(%r{</head[^>]*>}) { %(<link rel="stylesheet" href="/assets/cattle_tyrant.css" /><script src="/assets/cattle_tyrant.js"></script>\n#{$LAST_MATCH_INFO}) }
        body.sub!(/<body[^>]*>/) { %(#{$LAST_MATCH_INFO}\n<div id="cattle-tyrant" class="cattle-tyrant-custom"><span id="cattle-tyrant-open" class="cattle-tyrant-button">⏺</span><span id="cattle-tyrant-close" class="cattle-tyrant-button">⏹</span><span id="cattle-tyrant-copy" class="cattle-tyrant-button">📋</span></div>) }

        [status, headers, [body]]
      else
        [status, headers, body]
      end
    end
  end
end
