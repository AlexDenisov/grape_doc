require 'spec_helper'

describe GrapeDoc::DOCGenerator do
  describe "resources" do
    generator = DOCGenerator.new
    generator.resources.count.should == 2
  end
end



