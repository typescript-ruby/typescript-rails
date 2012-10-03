require 'rails/engine'

module Typescript
  module Rails
    class Engine < ::Rails::Engine
      # For now, let's not be the default generator ...
      # config.app_generators.javascript_engine :ts
    end
  end
end