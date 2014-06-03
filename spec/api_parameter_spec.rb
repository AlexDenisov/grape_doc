require 'spec_helper'
require 'test_classes/projects'

include GrapeDoc

describe GrapeDoc::APIParameter do
  let(:parser) { APIParser.new }
  let(:parameter) { APIParameter.new }

  describe "should respond to" do
    it "field" do
      expect(parameter.respond_to?(:field)).to eq(true)
    end
    it "description" do
      expect(parameter.respond_to?(:description)).to eq(true)
    end
    it "sample_value" do
      expect(parameter.respond_to?(:sample_value)).to eq(true)
    end
    it "field_type" do
      expect(parameter.respond_to?(:field_type)).to eq(true)
    end
  end

  describe "initialize within different data" do
    it "parse PUT project" do
      document = parser.parse(Projects)[2]
      params = document.params
      params.each do |p|
        expect(p.kind_of?(APIParameter)).to eq(true)
      end
    end
    it "parse PUT project with parameters" do
      document = parser.parse(Projects)[2]
      param = document.params.first
      expect(param.field).to eq("project_id")
      expect(param.description).to eq("Project ID")
      expect(param.required).to eq(true)
    end
  end
end

