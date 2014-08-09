require 'typescript-node'
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

      # @deprecated
      def self.default_no_wrap
        @@default_bare
      end

      # @deprecated
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
        source = Typescript::Rails.replace_relative_references(file, data)
        # TODO: employs source-maps
        @output ||= TypeScript::Node.compile(source, '--target', 'ES5')
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
        escaped_path = template.identifier.gsub(/['\\]/, '\\\\\&') # "'" => "\\'", '\\' => '\\\\'
        <<-EOS
        TypeScript::Node.compile(
          Typescript::Rails.replace_relative_references(
            '#{escaped_path}', (begin;#{compiled_source};end)
          ),
          '--target', 'ES5'
        )
        EOS
      end
    end

    # Replace relative paths specified in /// <reference path="..." /> with absolute paths.
    #
    # @param [String] ts_path Source .ts path
    # @param [String] ts source. It might be pre-processed by erb.
    # @return [String] replaces source
    def self.replace_relative_references(ts_path, source)
      ts_dir = File.dirname(File.expand_path(ts_path))
      escaped_dir = ts_dir.gsub(/["\\]/, '\\\\\&') # "\"" => "\\\"", '\\' => '\\\\'

      # Why don't we just use gsub? Because it display odd behavior with File.join on Ruby 2.0
      # So we go the long way around.
      output = ''
      source.each_line do |l|
        if l.starts_with?('///') && !(m = %r!^///\s*<reference\s+path="([^"]+)"\s*/>\s*!.match(l)).nil?
          l = l.sub(m.captures[0], File.join(escaped_dir, m.captures[0]))
        end

        output = output + l + $/
      end

      output
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler :ts, Typescript::Rails::TemplateHandler
end
