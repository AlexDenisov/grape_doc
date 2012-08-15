module GrapeDoc 
  class DOCGenerator 
    attr_accessor :resources, 
                  :formatter, 
                  :single_file
    def initialize
      self.resources = Grape::API.subclasses.map do |klass|
        resource = APIResource.new(klass)
        if resource.documents.nil? or resource.documents.count.zero?
          nil
        else
          resource
        end
      end.compact.sort_by{ |res| res.resource_name }
    end

    def init_formatter
      return GrapeDoc::MarkdownFormatter.new self.formatter.nil?
      
    end

    def generate
      doc_formatter = init_formatter
      generated_resources = self.resources.map do | resource |
        doc_formatter.generate_resource_doc resource
      end.join
      output = File.open("#{Dir.pwd}/doc/api.md", "w")
      output << generated_resources
    end
  end
end

