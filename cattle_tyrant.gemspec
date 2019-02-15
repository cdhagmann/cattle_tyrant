# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cattle_tyrant/version'

Gem::Specification.new do |spec|
  spec.name          = 'cattle_tyrant'
  spec.version       = CattleTyrant::VERSION
  spec.authors       = ['Chris Hagmann']
  spec.email         = ['cdhagmann@gmail.com']

  spec.summary       = 'The Capybara scenario writer'
  spec.description   = 'A Rails engine that generates Capybara scenario in the browser'
  spec.homepage      = 'https://github.com/cdhagmann/cattle_tyrant'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
