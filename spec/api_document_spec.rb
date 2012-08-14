require 'spec_helper'

describe "GrapeDoc::APIDocument" do
  describe "should respond to" do
    let(:api_document) {
      GrapeDoc::APIDocument.new 
    }
    it "resource" do
      api_document.respond_to?(:resource_name).should be_true
    end
    it "path" do
      api_document.respond_to?(:path).should be_true
    end
    it "description" do
      api_document.respond_to?(:description).should be_true
    end
    it "params" do
      api_document.respond_to?(:params).should be_true
    end
    it "response" do
      api_document.respond_to?(:response).should be_true
    end
    it "http_method" do
      api_document.respond_to?(:http_method).should be_true
    end
  end
end

