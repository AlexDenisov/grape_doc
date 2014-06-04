require 'spec_helper'

require 'test_classes/projects'
require 'test_classes/users'
include GrapeDoc

describe GrapeDoc::APIParser do
  let(:parser) { APIParser.new }
  describe "parse empty child class" do
    it "should return nil" do
      expect(parser.parse(Users)).to eq(nil)
    end
  end
  describe "parse non-empty child class" do
    it "should_not return nil" do
      expect(parser.parse(Projects)).not_to eq(nil)
    end
    it "should return two documents" do
      expect(parser.parse(Projects).count).to eq(4)
    end
    it "should return array of APIDocument objects" do
      parser.parse(Projects).each do |document|
        expect(document.kind_of?(APIDocument)).to eq(true)
      end
    end
    it "should parse GET route without meta info" do
      document = parser.parse(Projects).first
      expect(document.resource_name).to eq("Projects")
      expect(document.path).to eq("/projects")
      expect(document.http_method).to eq( "GET")
      expect(document.description).to eq(nil)
      expect(document.params).to eq(nil)
      expect(document.response).to eq(nil)
    end
    it "should parse POST route within meta info" do
      document = parser.parse(Projects)[1]
      expect(document.resource_name).to eq("Projects")
      expect(document.path).to eq("/projects")
      expect(document.http_method).to eq("POST")
      expect(document.description).to eq("Create Project")
      expect(document.params).to eq(nil)
      expect(document.response).to eq(nil)
    end
    it "should parse PUT route within meta info" do
      params = { 
        :project_id => { 
          :desc => "Project ID",
          :required => true
        }
      }
      document = parser.parse(Projects)[2]
      expect(document.resource_name).to eq("Projects")
      expect(document.path).to eq("/projects")
      expect(document.http_method).to eq("PUT")
      expect(document.description).to eq("Update Project")
      expect(document.response).to eq(nil)
    end
    it "should parse DELETE route within meta info" do
      params = { 
        :project_id => { 
          :desc => "Project ID",
          :required => true
        }
      }
      response = {
        :status => true
      }
      document = parser.parse(Projects)[3]
      expect(document.resource_name).to eq("Projects")
      expect(document.path).to eq("/projects")
      expect(document.http_method).to eq("DELETE")
      expect(document.description).to eq("Delete Project")
      # expect(document.params).to eq(params)
      expect(document.response).to eq(response)
    end
  end
end

