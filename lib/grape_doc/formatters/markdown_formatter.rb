module GrapeDoc
  class MarkdownFormatter #< #GrapeDoc::DOCFormatter
    def generate_resource_doc(resource)
      title = "### #{resource.resource_name}\n"
      
      documents = resource.documents.map do |document|
        path = "#### #{document.http_method} #{document.path}\n\n"
        description = "#{document.description}\n\n"
        parameters = document.params.map do |parameter| 
          next if parameter.field.nil? or parameter.field.empty?
          param = " - #{parameter.field}"
          param += " (#{parameter.field_type})" if parameter.field_type
          param += " (required)" if parameter.required
          param += " : #{parameter.description}\n\n"
        end.join if document.params
        route = "#{path} #{description}"
        route += "**Parameters:** \n\n\n#{parameters}" if parameters
        route += "\n\n"
      end.join
      return "" if documents.nil? or documents.empty?
      "#{title}\n\n\n#{documents}\n"
    end
  end
end

