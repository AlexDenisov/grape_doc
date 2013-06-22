module GrapeDoc 
  class DOCGenerator 
    attr_accessor :resources, 
                  :formatter, 
                  :single_file
    def initialize(resource_path)
      begin
        require resource_path
        self.load
      rescue LoadError => ex
        puts "#{ex}"
      end
    end

    def init_formatter
      return GrapeDoc::MarkdownFormatter.new if self.formatter.nil?
    end

    def load
      self.resources = Grape::API.subclasses.map do |klass|
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
      generated_resources = self.resources.map do | resource |
        doc_formatter.generate_resource_doc resource
      end.join
      doc_dir = "#{Dir.pwd}/grape_doc"
      doc_path = "#{doc_dir}/api.md"
      FileUtils.mkdir_p(doc_dir)
      output = File.open(doc_path, "w")
      output << generated_resources
    end
  end
end

