module GrapeDoc
  class APIDocument
    attr_accessor :resource_name, 
                  :path, 
                  :description, 
                  :params,
                  :response, 
                  :http_method
    def initialize(resource = nil, route = nil)
      return if route.nil?
      self.path = route.route_path.gsub('(.:format)','')
      self.resource_name = resource
      self.http_method = route.route_method
      self.description = route.route_description
      self.params = APIParameter.initialize_parameters route.route_params
      self.response = nil_or_empty route.route_response
    end

    private 
    def nil_or_empty(hash)
      if hash
        return hash.empty? ? nil : hash
      end
      hash
    end
  end
end

