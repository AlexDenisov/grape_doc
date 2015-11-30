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
      opt :batch, "Generate documentation for multiple APIs",
          :short => :B
      opt :bundle, "Run bundle on child APIs",
          :short => :b
      opt :output_dir, "Directory to save documentation file(s)",
          :type => :string,
          :default => File.expand_path(Dir.pwd + "/grape_doc")
      opt :resource_files, "API resource files, relative to project root",
          :type => :strings,
          :short => :F,
          :default => ["./config/environment.rb"]
      opt :root_api, "Top level API class name",
          :type => :string
      opt :stdout, "Print documentation stdout instead of generating files",
          :short => :s,
          :default => false
    end

    FileUtils.mkdir_p(opts[:output_dir]) if !opts[:stdout]

    if opts[:batch]
      dirs = Dir.glob('*').select{|f| File.directory?(f)}
      project_dirs = dirs.map{|d| File.expand_path(Dir.pwd + "/#{d}")}

      resource_markdown = []

      project_dirs.each do |d|
        Dir.chdir(d) do
          puts "Current DIR: #{d}"
          if opts[:resource_files].all? {|resource| File.file?(resource)}
            `bundle` if opts[:bundle]

            exec_command = 'grape_doc -s'
            exec_command << " --resource-files #{opts[:resource_files].join(' ')}" if opts[:resource_files]
            exec_command << " --root-api #{opts[:root_api]}" if opts[:root_api]

            resource_markdown << `#{exec_command}`
          end
        end
      end

      writer = DOCWriter.new opts[:output_dir], opts[:stdout]
      writer.output_body(resource_markdown.join, 'documentation')
    else
      generator = DOCGenerator.new opts
      generator.generate
    end
  end
end
