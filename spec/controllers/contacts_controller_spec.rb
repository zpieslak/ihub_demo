require 'spec_helper'

describe ContactsController do
  include Devise::TestHelpers

  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of contacts" do
      contact = @user.contacts.create!(attributes_for(:contact))
      get :index
      assigns(:contacts).should eq([contact])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested contact to @contact" do
      contact = @user.contacts.create!(attributes_for(:contact))
      get :show, :id => contact
      assigns(:contact).should eq(contact)
    end

    it "renders the #show view" do
      get :show, :id => @user.contacts.create!(attributes_for(:contact))
      response.should render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new contact" do
        expect{
          post :create, :contact => attributes_for(:contact)
        }.to change(Contact,:count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect{
          post :create, :contact => attributes_for(:contact, :name => '')
        }.to_not change(Contact,:count)
      end

      it "re-renders the new method" do
        post :create, :contact => attributes_for(:contact, :name => '')
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @contact = @user.contacts.create!(attributes_for(:contact))
    end

    context "valid attributes" do
      it "located the requested @contact" do
        put :update, :id => @contact, :contact => attributes_for(:contact)
        assigns(:contact).should eq(@contact)
      end

      it "changes @contact's attributes" do
        put :update, :id => @contact, :contact => attributes_for(:contact, :name => 'Different')
        @contact.reload
        @contact.name.should eq("Different")
      end
    end

    context "invalid attributes" do
      it "does not change @contact's attributes" do
        put :update, :id => @contact, :contact => attributes_for(:contact, :name => '')
        @contact.reload
        @contact.name.should_not eq('')
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @contact = @user.contacts.create!(attributes_for(:contact))
      request.env["HTTP_REFERER"] = contacts_url
    end

    it "deletes the contact" do
      expect{
        delete :destroy, :id => @contact
      }.to change(Contact,:count).by(-1)
    end
  end
end
