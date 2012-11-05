class GroupsController < ApplicationController
  load_and_authorize_resource

  def index
    @groups = current_user.groups
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @group = current_user.groups.new(params[:group])
    if @group.save
      redirect_to groups_path, :flash => { :notice => "Group created successfully" }
    else
      flash.now[:error] = "There was an error"
      render :action => :new
    end
  end

  def update
    if @group.update_attributes(params[:group])
      redirect_to groups_path, :flash => { :notice => "Group updated successfully" }
    else
      flash.now[:error] = "There was an error"
      render :action => :edit
    end
  end

  def destroy
    if @group.destroy
      flash.now[:notice] = "Group deleted successfully"
    else
      flash.now[:error] = "There was an error"
    end

    redirect_to :back
  end
end
