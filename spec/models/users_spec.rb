require 'spec_helper'

describe "Users" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  it "should create a new instance of a user given valid attributes" do
    @user.should be_persisted
    @user.status.should == "user"
  end
end
