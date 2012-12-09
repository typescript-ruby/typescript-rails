require 'tilt'

module Typescript
  module Rails

    class TypeScriptTemplate < ::Tilt::Template
      self.default_mime_type = 'application/javascript'

      @@default_bare = false

      def self.default_bare
        @@default_bare
      end

      def self.default_bare=(value)
        @@default_bare = value
      end

      # DEPRECATED
      def self.default_no_wrap
        @@default_bare
      end

      # DEPRECATED
      def self.default_no_wrap=(value)
        @@default_bare = value
      end

      def self.engine_initialized?
        defined? ::TypeScript
      end

      def initialize_engine
        require_template_library 'coffee_script'
      end

      def prepare
        if !options.key?(:bare) and !options.key?(:no_wrap)
          options[:bare] = self.class.default_bare
        end
      end

      def evaluate(scope, locals, &block)
        @output ||= TypeScript::Node.compile(data)
      end

      def allows_script?
        false
      end
    end

    class TemplateHandler

      def self.erb_handler
        @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end

      def self.call(template)
        compiled_source = erb_handler.call(template)
        "TypeScript::Node.compile(begin;#{compiled_source};end)"
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler :ts, Typescript::Rails::TemplateHandler
end
