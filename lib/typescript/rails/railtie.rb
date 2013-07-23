module Typescript
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_initialize do |app|
        require 'typescript-rails'

        if ::Rails::VERSION::MAJOR >= 4 || app.config.assets.enabled
          require 'sprockets'
          require 'sprockets/engines'
          Sprockets.register_engine '.ts', Typescript::Rails::TypeScriptTemplate
        end
      end
    end
  end
end