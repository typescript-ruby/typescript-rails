require 'typescript/rails'
require 'tilt/template'

class Typescript::Rails::Template < ::Tilt::Template
  self.default_mime_type = 'application/javascript'

  # @!scope class
  class_attribute :default_bare

  def self.engine_initialized?
    defined? ::Typescript::Rails::Compiler
  end

  def initialize_engine
    require_template_library 'typescript/rails/compiler'
  end

  def prepare
    if !options.key?(:bare) and !options.key?(:no_wrap)
      options[:bare] = self.class.default_bare
    end
  end

  def evaluate(scope, locals, &block)
    begin
    @output ||= ::Typescript::Rails::Compiler.compile(file, data)
    
    # This is hacky as hell but it works for now
    rescue RuntimeError => e
      if e.message =~ /error\sTS\d+:\s/ # Got TypeScript error (probably)?
        # Replace path to tempfile in error with path to asset file
        # TODO: Fix hacky regexp
        raise RuntimeError, e.message.gsub(/^\/.*\.ts\(/, "#{file}(")
      else
        raise e
      end
    end
  end

  # @override
  def allows_script?
    false
  end
end
