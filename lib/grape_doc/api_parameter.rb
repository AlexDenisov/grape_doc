module GrapeDoc
  class APIParameter
    attr_accessor :field, 
                  :description, 
                  :sample_value, 
                  :field_type,
                  :required
    def initialize(parameter_name = nil, 
                   parameter_hash = nil)
      return if parameter_name.nil? or 
                parameter_hash.nil?
      self.field = parameter_name.to_s
      self.required = parameter_hash[:requires] || 
                      parameter_hash[:required]
      self.description =  parameter_hash[:desc] ||
                          parameter_hash[:description]
    end
    def self.initialize_parameters(params_hash)
      params = params_hash.map do |name, hash|
        APIParameter.new(name, hash)
      end
      return nil if params.empty?
      params
    end
  end
end

