module Typescript
  module Rails
    module JsHook
      extend ActiveSupport::Concern

      included do
        no_tasks do
          redefine_method :js_template do |source, destination|
            template(source + '.ts', destination + '.ts')
          end
        end
      end
    end
  end
end
