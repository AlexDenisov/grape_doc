#require File.expand_path(File.join(Dir.pwd, 'config', 'environment'))
require 'grape_doc/version'
require 'grape_doc/api_document'
require 'grape_doc/api_parser'

module GrapeDoc
  def self.generate_doc
    Grape::API.subclasses.each do |klass|
      puts klass
    end
  end
end
