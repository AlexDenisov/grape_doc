require 'spec_helper'

require 'test_classes/projects'

include GrapeDoc

describe GrapeDoc::APIParameter do
  let(:parser) { APIParser.new }
  let(:parameter) { APIParameter.new }

  describe "should respond to" do
    it "field" do
      parameter.respond_to?(:field).should be_true
    end
    it "description" do
      parameter.respond_to?(:description).should be_true
    end
    it "sample_value" do
      parameter.respond_to?(:sample_value).should be_true
    end
    it "field_type" do
      parameter.respond_to?(:field_type).should be_true
    end
  end

  describe "initialize within different data" do
    it "parse PUT project" do
      document = parser.parse(Projects)[2]
      params = document.params
      params.each do |p|
        p.kind_of?(APIParameter).should be_true
      end
    end
    it "parse PUT project with parameters" do
      document = parser.parse(Projects)[2]
      param = document.params.first
      param.field.should == "project_id"
      param.description.should == "Project ID"
      param.required.should be_true
    end
  end
end

