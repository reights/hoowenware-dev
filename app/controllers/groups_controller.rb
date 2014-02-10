class GroupsController < ApplicationController
  before_action :authorize_admin!, only: [:destroy]
  before_action :set_group, only: [:show, :edit, :update, :cancel,
                                    :reactivate, :destroy]
  before_filter :check_for_cancel, :only => [:create, :update]


  def index
    @groups = Group.order('name ASC')
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @group.update(is_active: true)
      flash[:notice] = "Your group has been created."
      redirect_to @group
    else
      flash[:alert] = "Your group has not been created."
      render "new"
    end
  end

  def show
    #set_group
  end

  def edit
    #set_group
  end

  def update
    #set_group
    if @group.update(group_params)
      flash[:notice] = "Your group has been updated."
      redirect_to @group
    else
      flash[:alert] = "Your group has not been updated."
      render "edit"
    end
  end

  def cancel
    if current_user == @group.user
      @group.update(is_active: false)

      flash[:notice] = "Your group has been cancelled."
      redirect_to user_path(current_user.id)
    else
      flash[:alert] = "You must be an administrator of this group to do that."
      redirect_to groups_path
    end
  end

  def reactivate
    if current_user == @group.user
      @group.update(is_active: true)

      flash[:notice] = "Your group has been reactivated."
      redirect_to user_path(current_user.id)
    else
      flash[:alert] = "You must be an administrator of this group to do that."
      redirect_to groups_path
    end
  end

  def destroy
    #set_group
    @group.destroy

    flash[:notice] = "This group has been deleted."
    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

    def set_group
      @group = Group.find(params[:id])
   rescue ActiveRecord::RecordNotFound
     flash[:alert] = "The group you were looking for could not be found."
     redirect_to groups_path
    end

    def check_for_cancel
      if params[:commit] == "Cancel"
        flash[:notice] = "Your changes have been cancelled."
        redirect_to @group
      end
    end
end
