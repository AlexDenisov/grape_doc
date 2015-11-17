module GrapeDoc
  class APIResource
    attr_accessor :documents
    attr_accessor :resource_name
    def initialize(klass)
      self.resource_name = klass.to_s.split("::").first
      self.documents = APIParser.parse klass
    end
  end
end

