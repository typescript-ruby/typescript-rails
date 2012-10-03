# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typescript-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "typescript-rails"
  gem.version       = Typescript::Rails::VERSION
  gem.authors       = ["Klaus Zanders"]
  gem.email         = ["klaus.zanders@gmail.com"]
  gem.description   = %q{Adds Typescript to the Rails Asset pipeline}
  gem.summary       = %q{Adds Typescript to the Rails Asset pipeline}
  gem.homepage      = ""

  gem.add_runtime_dependency 'typescript'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
