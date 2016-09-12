require "rails/generators/named_base"

module Typescript
  module Generators
    class AssetsGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def copy_typescript
        template "javascript.ts", File.join('app/assets/javascripts', class_path, "#{file_name}.ts")
      end
    end
  end
end
