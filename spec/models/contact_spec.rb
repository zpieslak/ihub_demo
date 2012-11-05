require 'spec_helper'

describe Contact do
  before(:each) do
    @user = create(:user)
    @group = @user.groups.create!(attributes_for(:group))
    @attr = attributes_for(:contact).merge(:group_id => @group.id)
  end

  it "should create a new instance given a valid attribute" do
    @user.contacts.create!(@attr)
  end

  it "should require a name" do
    no_name_contact = @user.contacts.new(@attr.merge(:name => ""))
    no_name_contact.should_not be_valid
  end

  it "should reject too long name" do
    long_name = "a" * 256
    long_name_contact = @user.contacts.new(@attr.merge(:name => long_name))
    long_name_contact.should_not be_valid
  end

  it "should reject wrong email" do
    wrong_email = "wrong_email"
    wrong_email_contact = @user.contacts.new(@attr.merge(:email => wrong_email))
    wrong_email_contact.should_not be_valid
  end

  it "should reject too long phone" do
    long_phone = "a" * 256
    long_phone_contact = @user.contacts.new(@attr.merge(:phone => long_phone))
    long_phone_contact.should_not be_valid
  end
end
