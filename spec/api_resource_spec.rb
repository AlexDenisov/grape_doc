require 'spec_helper'
require 'test_classes/projects'

describe GrapeDoc::APIResource do
  it "should have 4 documents" do
    resource = APIResource.new(Projects)
    resource.documents.count.should == 4
  end
end

