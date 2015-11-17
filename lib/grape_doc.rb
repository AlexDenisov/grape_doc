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
      opt :batch, "Generate docs for multiple APIs",
          :short => :B
      opt :bundle, "Run bundle on child APIs",
          :short => :b
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

    if opts[:batch]
      dirs = Dir.glob('*').select{|f| File.directory?(f)}
      project_dirs = dirs.map{|d| File.expand_path(Dir.pwd + "/#{d}")}

      resource_markdown = []

      project_dirs.each do |d|
        if File.file?(d + '/app.rb')
          $stdout.puts "Creating docs for: #{d.split('/').last}"

          Dir.chdir(d) do
            `bundle` if opts[:bundle]

            exec_command = 'grape_doc -s'
            exec_command << " --paths #{opts[:paths].join(' ')}" if opts[:paths]
            exec_command << " --root-api #{opts[:root_api]}" if opts[:root_api]

            resource_markdown << `#{exec_command}`
          end
        end
      end

      writer = DOCWriter.new opts[:doc_dir], opts[:stdout]
      writer.output_body(resource_markdown.join, 'documentation')

      $stdout.puts "Documentation location: #{opts[:doc_dir]}/documentation.md"
    else
      generator = DOCGenerator.new opts
      generator.generate
    end
  end
end
