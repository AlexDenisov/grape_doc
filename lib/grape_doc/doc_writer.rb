module GrapeDoc
  class DOCWriter
    def initialize(output_dir, stdout)
      @output_dir = output_dir
      @stdout = stdout
    end

    def output_body(body, resource_name)
      if @stdout
        $stdout.print body
      else
        generate_files body, resource_name
      end
    end

    def generate_files(body, resource_name)
      File.open(File.join(@output_dir, "#{resource_name}.md"), 'w') {|f| f.write body }
    end
  end
end
