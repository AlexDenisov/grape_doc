module GrapeDoc
  class DOCGenerator
    attr_accessor :resources,
                  :formatter,
                  :single_file
    def initialize(args = {})
      begin
        args[:resource_paths].each { |resource| require resource }

        @doc_dir = args[:doc_dir]
        @stdout = args[:stdout] || false

        @api_classes = if args[:root_api]
          args[:root_api].constantize.endpoints.map{|endpoint| endpoint.options[:app] }
        else
          Grape::API.subclasses
        end

        self.load
      rescue LoadError => ex
        puts "#{ex}"
      end
    end

    def init_formatter
      return GrapeDoc::MarkdownFormatter.new if self.formatter.nil?
    end

    def load
      self.resources = @api_classes.map do |klass|
        resource = APIResource.new(klass)
        if resource.documents.nil? or resource.documents.count.zero?
          nil
        else
          resource
        end
      end.compact.sort_by{ |res| res.resource_name }
    end

    def generate
      doc_formatter = init_formatter

      self.resources.each do | resource |
        body = doc_formatter.generate_resource_doc(resource)

        output_body(body, resource)
      end
    end

    def output_body(body, resource)
      if @stdout
        $stdout.print body
      else
        generate_files body, resource
      end
    end

    def generate_files(body, resource)
      File.open(File.join(@doc_dir, "#{resource.resource_name}.md"), 'w') {|f| f.write body }
    end

  end
end
