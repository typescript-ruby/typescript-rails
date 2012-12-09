# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'typescript/rails/version'

Gem::Specification.new do |gem|
  gem.name          = "typescript-rails"
  gem.version       = Typescript::Rails::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Klaus Zanders"]
  gem.email         = ["klaus.zanders@gmail.com"]
  gem.description   = %q{Adds Typescript to the Rails Asset pipeline}
  gem.summary       = %q{Adds Typescript to the Rails Asset pipeline}
  gem.homepage      = "http://github.com/klaustopher/typescript-rails"

  gem.rubyforge_project = "typescript-rails"

  gem.add_runtime_dependency 'typescript-node', '~> 0.0'
  gem.add_runtime_dependency 'tilt',      '~> 1.3'
  gem.add_runtime_dependency 'railties'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 1.9.2"
end
