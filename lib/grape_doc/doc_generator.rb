module GrapeDoc
  class DOCGenerator
    attr_accessor :resources,
                  :formatter,
                  :single_file
    def initialize(args = {})
      begin
        args[:paths].each { |resource| require resource }

        @output_dir = args[:output_dir]
        @stdout = args[:stdout]
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
      writer = DOCWriter.new @output_dir, @stdout

      self.resources.each do | resource |
        body = doc_formatter.generate_resource_doc(resource)

        writer.output_body(body, resource.resource_name)
      end
    end

  end
end
