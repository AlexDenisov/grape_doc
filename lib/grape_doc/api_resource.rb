module GrapeDoc
  class APIResource
    attr_accessor :documents
    def initialize(klass)
      self.documents = APIParser.parse klass
    end
  end
end

