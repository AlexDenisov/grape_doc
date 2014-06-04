require 'spec_helper'

describe "GrapeDoc::APIDocument" do
  describe "should respond to" do
    let(:api_document) {
      GrapeDoc::APIDocument.new 
    }
    it "resource" do
      expect(api_document.respond_to?(:resource_name)).to eq(true)
    end
    it "path" do
      expect(api_document.respond_to?(:path)).to eq(true)
    end
    it "description" do
      expect(api_document.respond_to?(:description)).to eq(true)
    end
    it "params" do
      expect(api_document.respond_to?(:params)).to eq(true)
    end
    it "response" do
      expect(api_document.respond_to?(:response)).to eq(true)
    end
    it "http_method" do
      expect(api_document.respond_to?(:http_method)).to eq(true)
    end
  end
end

