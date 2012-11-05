class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    @contacts = current_user.contacts
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @contact = current_user.contacts.new(params[:contact])
    if @contact.save
      redirect_to contacts_path, :flash => { :notice => "Contact created successfully" }
    else
      flash.now[:error] = "There was an error"
      render :action => :new
    end
  end

  def update
    if @contact.update_attributes(params[:contact])
      redirect_to contacts_path, :flash => { :notice => "Contact updated successfully" }
    else
      flash.now[:error] = "There was an error"
      render :action => :edit
    end
  end

  def destroy
    if @contact.destroy
      flash.now[:notice] = "Contact deleted successfully"
    else
      flash.now[:error] = "There was an error"
    end

    redirect_to :back
  end
end
