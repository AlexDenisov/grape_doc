require 'spec_helper'
require 'test_classes/api'

describe "Grape::API::Subclasses" do
  it "should return 2 Grape::API subclasses" do
    Grape::API.subclasses.count.should == 3
  end
  it "should return Grape::API subclasses" do
    Grape::API.subclasses[1].should == Projects
    Grape::API.subclasses[2].should == Users
  end
  it "should return sorted Grape::API subclasses" do
    5.times do
      Grape::API.subclasses[2].should_not == Projects
    end
  end
end

