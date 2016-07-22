require 'typescript/rails'

class Typescript::Rails::Transformer
  def self.instance
    @instance ||= new
  end

  def self.call(input)
    instance.call(input)
  end

  def call(input)
    filename = input[:filename]
    source   = input[:data]
    context  = input[:environment].context_class.new(input)

    result = ::Typescript::Rails::Compiler.compile(filename, source, context)
    { data: result }
  end
end
