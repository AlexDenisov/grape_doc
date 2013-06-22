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
      doc_dir = "#{Dir.pwd}/grape_doc"
      Dir::mkdir(doc_dir)

      self.resources.each do | resource |
        File.open(File.join(doc_dir, "#{resource.resource_name}.md"), 'w') {|f| f.write doc_formatter.generate_resource_doc(resource) }
      end
    end
  end
end

