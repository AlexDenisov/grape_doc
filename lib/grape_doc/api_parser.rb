module GrapeDoc
  class APIParser
    def self.parse(klass)
      return nil if klass.routes.count.zero?
      documents = klass.routes.map do |route|
        resource = klass.to_s.split("::").first
        document = APIDocument.new(resource, route)
        if document.empty
          nil
        else
          document
        end
      end.compact.sort_by{ |doc| doc.resource_name }
    end

    def parse(klass)
      self.class.parse klass
    end
  end
end
