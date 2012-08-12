require 'core_ext/object'
require 'grape_doc/version'
require 'grape_doc/api_document'
require 'grape_doc/api_parser'
require 'grape_doc/api_parameter'
require 'grape_doc/api_resource'
require 'grape_doc/doc_generator'

module GrapeDoc
  def self.generate_doc
    Grape::API.subclasses.each do |klass|
      puts klass
    end
  end
end
