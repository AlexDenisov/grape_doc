require 'spec_helper'

describe GrapeDoc::DOCGenerator do
  it "resources" do
    generator = DOCGenerator.new
    generator.resources.count.should == 3
  end
end



