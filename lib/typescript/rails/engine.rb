require 'rails/engine'
require 'rails/generators'
require 'typescript/rails/js_hook'

class Typescript::Rails::Engine < Rails::Engine
  # To become the default generator...
  # config.app_generators.javascript_engine :typescript

  if config.respond_to?(:annotations)
    config.annotations.register_extensions(".ts") { |annotation| /#\s*(#{annotation}):?\s*(.*)$/ }
  end

  initializer 'override js_template hook' do |app|
    if app.config.generators.rails[:javascript_engine] == :typescript
      ::Rails::Generators::NamedBase.send :include, Typescript::Rails::JsHook
    end
  end
end
