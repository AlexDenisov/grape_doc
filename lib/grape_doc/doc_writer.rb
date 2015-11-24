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

      $stdout.puts "Creating documentation for: #{resource_name}"
    end

    def generate_files(body, resource_name)
      File.open(File.join(@output_dir, "#{resource_name}.md"), 'w') {|f| f.write body }
      $stdout.puts "Documentation location: #{@output_dir}/#{resource_name}.md"
    end
  end
end
