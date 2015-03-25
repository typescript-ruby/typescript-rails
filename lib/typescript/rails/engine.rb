require 'rails/engine'

class Typescript::Rails::Engine < Rails::Engine
  # config.app_generators.javascript_engine :typescript

  if config.respond_to?(:annotations)
    config.annotations.register_extensions("ts") { |annotation| /#\s*(#{annotation}):?\s*(.*)$/ }
  end
end