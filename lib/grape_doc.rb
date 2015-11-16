require 'core_ext/object'
require 'grape_doc/version'
require 'grape_doc/api_document'
require 'grape_doc/api_parser'
require 'grape_doc/api_parameter'
require 'grape_doc/api_resource'
require 'grape_doc/doc_generator'
require 'grape_doc/formatters/markdown_formatter'
require 'trollop'

module GrapeDoc
  def self.generate_doc
    opts = Trollop::options do
      opt :paths, "Resource paths",
          :type => :strings,
          :default => [File.expand_path(Dir.pwd + "/config/environment")]
    end
    generator = DOCGenerator.new opts[:paths]
    generator.generate
  end
end
