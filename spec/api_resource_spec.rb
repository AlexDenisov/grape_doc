require 'spec_helper'
require 'test_classes/projects'

describe GrapeDoc::APIResource do
  it "should have 4 documents" do
    resource = APIResource.new(Projects)
    expect(resource.documents.count).to eq(4)
  end
end

