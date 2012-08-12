require 'spec_helper'
#require 'core_ext/object'

describe "Grape::API::Subclasses" do
  it "should return 2 Grape::API subclasses" do
    Grape::API.subclasses.count.should == 2
  end
  it "should return Grape::API subclasses" do
    Grape::API.subclasses[0].should == Projects
    Grape::API.subclasses[1].should == Users
  end
  it "should return sorted Grape::API subclasses" do
    5.times do
      Grape::API.subclasses[1].should_not == Projects
    end
  end
end

