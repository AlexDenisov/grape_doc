require 'spec_helper'

require 'test_classes/projects'
require 'test_classes/users'
include GrapeDoc

describe GrapeDoc::APIParser do
  let(:parser) { APIParser.new }
  describe "parse empty child class" do
    it "should return nil" do
      parser.parse(Users).should be_nil
    end
  end
  describe "parse non-empty child class" do
    it "should_not return nil" do
      parser.parse(Projects).should_not be_nil
    end
    it "should return two documents" do
      parser.parse(Projects).count.should == 4
    end
    it "should return array of APIDocument objects" do
      parser.parse(Projects).each do |document|
        document.kind_of?(APIDocument).should be_true
      end
    end
    it "should parse GET route without meta info" do
      document = parser.parse(Projects).first
      document.resource_name.should == "Projects"
      document.path.should == "/projects"
      document.http_method.should == "GET"
      document.description.should be_nil
      document.params.should be_nil
      document.response.should be_nil
    end
    it "should parse POST route within meta info" do
      document = parser.parse(Projects)[1]
      document.resource_name.should == "Projects"
      document.path.should == "/projects"
      document.http_method.should == "POST"
      document.description.should == "Create Project"
      document.params.should be_nil
      document.response.should be_nil
    end
    it "should parse PUT route within meta info" do
      params = { 
        :project_id => { 
          :description => "Project ID",
          :required => true
        }
      }
      document = parser.parse(Projects)[2]
      document.resource_name.should == "Projects"
      document.path.should == "/projects"
      document.http_method.should == "PUT"
      document.description.should == "Update Project"
      document.params.should == params
      document.response.should be_nil
    end
    it "should parse PUT route within meta info" do
      params = { 
        :project_id => { 
          :description => "Project ID",
          :required => true
        }
      }
      response = {
        :status => true
      }
      document = parser.parse(Projects)[3]
      document.resource_name.should == "Projects"
      document.path.should == "/projects"
      document.http_method.should == "DELETE"
      document.description.should == "Delete Project"
      document.params.should == params
      document.response.should == response
    end
  end
end

