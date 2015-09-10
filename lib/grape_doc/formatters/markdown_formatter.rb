module GrapeDoc
  class MarkdownFormatter 
    def generate_resource_doc(resource)
      title = "### #{resource.resource_name}\n"
      
      documents = resource.documents.map do |document|
        path = "#### #{document.http_method} #{escape(document.path)}\n\n"
        description = "#{document.description}\n\n"
        
        parameters = document.params.map do |parameter| 
          next if parameter.field.nil? or parameter.field.empty?
          param = " - #{escape(parameter.field)}"
          param += " (#{parameter.field_type})" if parameter.field_type
          param += " (*required*)" if parameter.required
          param += " : #{parameter.description} " if parameter.description
          param += " Example: #{parameter.sample_value}" if parameter.sample_value
          param += "\n\n"
        end.join if document.params
        
        route = "#{path} #{description}"
        route += "**Parameters:** \n\n\n#{parameters}" if parameters
        route += "\n\n"

      end.join
      return "" if documents.nil? or documents.empty?
      "#{title}\n\n\n#{documents}\n"
    end

    private

    def escape(str)
      str.gsub('_', '\_').
          gsub('[', '\[').
          gsub(']', '\]')
    end
  end
end
