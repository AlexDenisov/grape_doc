module GrapeDoc 
  class DOCGenerator 
    attr_accessor :resources
    def initialize
      self.resources = Grape::API.subclasses.map do |klass|
        APIResource.new(klass)
      end
    end
  end
end

