require 'typescript/rails/compiler'

class Typescript::Rails::TemplateHandler
  class << self
    def erb_handler
      @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb_handler.call(template)
      path = template.identifier.gsub(/['\\]/, '\\\\\&') # "'" => "\\'", '\\' => '\\\\'
      <<-EOS
        ::Typescript::Rails::Compiler.compile('#{path}', (begin;#{compiled_source};end))
      EOS
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler :ts, Typescript::Rails::TemplateHandler
end
