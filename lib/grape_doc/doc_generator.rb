module GrapeDoc 
  class DOCGenerator 
    attr_accessor :resources, 
                  :formatter, 
                  :single_file
    def initialize
      self.resources = Grape::API.subclasses.map do |klass|
        APIResource.new(klass)
      end
    end

    def init_formatter
      return GrapeDoc::MarkdownFormatter.new self.formatter.nil?
      
    end

    def generate
      doc_formatter = init_formatter
      generated_resources = self.resources.map do | resource |
        resource_doc = doc_formatter.generate_resource_doc resource
        puts resource_doc
        resource_doc
      end 
    end
  end
end

