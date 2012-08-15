require 'core_ext/object'
require 'grape_doc/version'
require 'grape_doc/api_document'
require 'grape_doc/api_parser'
require 'grape_doc/api_parameter'
require 'grape_doc/api_resource'
require 'grape_doc/doc_generator'
require 'grape_doc/formatters/markdown_formatter'

begin
require File.expand_path(Dir.pwd + "/config/environment")
rescue LoadError => ex
  puts "#{ex}"
end

module GrapeDoc
  def self.generate_doc
    generator = DOCGenerator.new
    generator.generate
  end
end
