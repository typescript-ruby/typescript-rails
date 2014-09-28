require 'typescript/rails'
require 'typescript-node'

module Typescript::Rails::Compiler
  class << self
    # @!scope class
    cattr_accessor :default_options

    # Replace relative paths specified in /// <reference path="..." /> with absolute paths.
    #
    # @param [String] ts_path Source .ts path
    # @param [String] source. It might be pre-processed by erb.
    # @return [String] replaces source
    def replace_relative_references(ts_path, source)
      ts_dir = File.dirname(File.expand_path(ts_path))
      escaped_dir = ts_dir.gsub(/["\\]/, '\\\\\&') # "\"" => "\\\"", '\\' => '\\\\'

      # Why don't we just use gsub? Because it display odd behavior with File.join on Ruby 2.0
      # So we go the long way around.
      output = []
      source.each_line do |l|
        if l.starts_with?('///') && !(m = %r!^///\s*<reference\s+path="([^"]+)"\s*/>\s*!.match(l)).nil?
          output << l.sub(m.captures[0], File.join(escaped_dir, m.captures[0]))
        else
          output << l
        end
      end

      output.join('')
    end

    # @param [String] ts_path
    # @param [String] source TypeScript source code
    # @return [String] compiled JavaScript source code
    def compile(ts_path, source, *options)
      s = replace_relative_references(ts_path, source)
      ::TypeScript::Node.compile(s, *default_options, *options)
    end

  end

  self.default_options = [
      '--target', 'ES5',
      '--noImplicitAny'
  ]
end
