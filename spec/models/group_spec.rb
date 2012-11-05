require 'spec_helper'

describe Group do
  before(:each) do
    @user = create(:user)
    @attr = attributes_for(:group)
  end

  it "should create a new instance given a valid attribute" do
    @user.groups.create!(@attr)
  end

  it "should require a name" do
    no_name_group = @user.groups.new(@attr.merge(:name => ""))
    no_name_group.should_not be_valid
  end

  it "should reject too long name" do
    long_name = "a" * 256
    long_name_group = @user.groups.new(@attr.merge(:name => long_name))
    long_name_group.should_not be_valid
  end
end
