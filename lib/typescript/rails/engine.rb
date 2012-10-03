require 'rails/engine'

module Typescript
  module Rails
    class Engine < ::Rails::Engine
      config.app_generators.javascript_engine :typescript
    end
  end
end