require 'spec_helper'

describe GroupsController do
  include Devise::TestHelpers

  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of groups" do
      group = @user.groups.create!(attributes_for(:group))
      get :index
      assigns(:groups).should eq([group])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested group to @group" do
      group = @user.groups.create!(attributes_for(:group))
      get :show, :id => group
      assigns(:group).should eq(group)
    end

    it "renders the #show view" do
      get :show, :id => @user.groups.create!(attributes_for(:group))
      response.should render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new group" do
        expect{
          post :create, :group => attributes_for(:group)
        }.to change(Group,:count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new group" do
        expect{
          post :create, :group => attributes_for(:group, :name => '')
        }.to_not change(Group,:count)
      end

      it "re-renders the new method" do
        post :create, :group => attributes_for(:group, :name => '')
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @group = @user.groups.create!(attributes_for(:group))
    end

    context "valid attributes" do
      it "located the requested @group" do
        put :update, :id => @group, :group => attributes_for(:group)
        assigns(:group).should eq(@group)
      end

      it "changes @group's attributes" do
        put :update, :id => @group, :group => attributes_for(:group, :name => 'Different')
        @group.reload
        @group.name.should eq("Different")
      end
    end

    context "invalid attributes" do
      it "does not change @group's attributes" do
        put :update, :id => @group, :group => attributes_for(:group, :name => '')
        @group.reload
        @group.name.should_not eq('')
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @group = @user.groups.create!(attributes_for(:group))
      request.env["HTTP_REFERER"] = groups_url
    end

    it "deletes the group" do
      expect{
        delete :destroy, :id => @group
      }.to change(Group,:count).by(-1)
    end
  end
end
