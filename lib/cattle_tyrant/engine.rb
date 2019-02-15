# frozen_string_literal: true

require_relative 'middleware'

module CattleTyrant
  class Engine < ::Rails::Engine #:nodoc:
    initializer 'CattleTyrant' do |app|
      app.middleware.use CattleTyrant::Middleware

      app.config.assets.precompile += %w[cattle_tyrant.js cattle_tyrant.css]
    end
  end
end
