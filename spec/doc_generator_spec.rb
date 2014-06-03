require 'spec_helper'

describe GrapeDoc::DOCGenerator do
  it "resources" do
    generator = DOCGenerator.new
    expect(generator.resources.count).to eq(1)
  end
end
