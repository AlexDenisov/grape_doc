module GrapeDoc
  class APIParser
    def self.parse(klass)
      return nil if klass.routes.count.zero?
      documents = klass.routes.map do |route|
        resource = klass.to_s.split("::").last
        APIDocument.new(resource, route)
      end
    end
    def parse(klass)
      self.class.parse klass
    end
  end
end
  
