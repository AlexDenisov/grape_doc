module GrapeDoc
  class APIParser
    def parse(klass)
      return nil if klass.routes.count.zero?
      documents = klass.routes.map do |route|
        resource = klass.to_s.split("::").last
        APIDocument.new(resource, route)
      end
    end
  end
end
  
