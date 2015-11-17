require 'core_ext/object'
require 'grape_doc/version'
require 'grape_doc/api_document'
require 'grape_doc/api_parser'
require 'grape_doc/api_parameter'
require 'grape_doc/api_resource'
require 'grape_doc/doc_writer'
require 'grape_doc/doc_generator'
require 'grape_doc/formatters/markdown_formatter'
require 'trollop'

module GrapeDoc
  def self.generate_doc
    opts = Trollop::options do
      opt :doc_dir, "Documentation save location",
          :type => :string,
          :default => File.expand_path(Dir.pwd + "/grape_doc")
      opt :paths, "Resource paths",
          :type => :strings,
          :default => [File.expand_path(Dir.pwd + "/config/environment")]
      opt :root_api, "Top level API",
          :type => :string
      opt :stdout, "Print documentation instead of generating files",
          :short => :s,
          :default => false
    end

    FileUtils.mkdir_p(opts[:doc_dir]) if !opts[:stdout]

    generator = DOCGenerator.new opts
    generator.generate
  end
end
