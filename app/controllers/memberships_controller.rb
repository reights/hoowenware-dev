class MembershipsController < ApplicationController
  before_action :set_group
  before_action :set_membership, only: [:approve, :pend, :promote, :demote,
                                        :remove]
  before_filter :authenticate_user!

  def new
    #set_group
    @membership = @group.memberships.build
    @is_group_admin = is_group_admin?(current_user)
  end

  def create
    #set_group
    @membership = @group.memberships.build(membership_params)
    if is_group_admin?(current_user) or current_user.is_admin?
      if @membership.save
        flash[:notice] = "Member has been added to this group."
        redirect_to group_path(@group)
      else
        flash[:alert] = "Duplicate members cannot be added to group."
        redirect_to group_path(@group)
      end
    else
      flash[:notice] = "You must be a group admin to do that."
      redirect_to group_path(@group)
    end
  end

  def approve
    if is_group_admin?(current_user) or current_user.is_admin?
      @membership.update(is_active: true, last_updated_by: current_user.id)
      flash[:notice] = "Membership has been activated."
      redirect_to group_path(@group)
    else
      flash[:notice] = "You must be a group admin to do that."
      redirect_to group_path(@group)
    end
  end

  def pend
    if is_group_admin?(current_user) or current_user.is_admin?
      if current_user.email  == @membership.email
        flash[:alert] = "Error, you can't set yourself to pending."
        redirect_to group_path(@group)
      else
        @membership.update(is_active: false, last_updated_by: current_user.id)

        flash[:notice] = "Membership has been suspended."
        redirect_to group_path(@group)
      end
    else
      flash[:notice] = "You must be a group admin to do that."
      redirect_to group_path(@group)
    end
  end

  def promote
    if is_group_admin?(current_user) or current_user.is_admin?
      @membership.update(is_active: true, is_admin: true, last_updated_by: current_user.id)

      flash[:notice] = "Membership has been upgraded to group administrator."
      redirect_to group_path(@group)
    else
      flash[:notice] = "You must be a group admin to do that."
      redirect_to group_path(@group)
    end
  end

  def demote
    if is_group_admin?(current_user) or current_user.is_admin?
      if current_user.email  == @membership.email
        flash[:alert] = "Error, you can't demote yourself."
        redirect_to group_path(@group)
      else
        @membership.update(is_admin: false, last_updated_by: current_user.id)

        flash[:notice] = "Membership has been set to normal user."
        redirect_to group_path(@group)
      end
    else
      flash[:notice] = "You must be a group admin to do that."
      redirect_to group_path(@group)
    end
  end

  def remove
    #set_membership
    if is_group_admin?(current_user) or current_user.is_admin?
      if current_user.email  == @membership.email
        flash[:alert] = "Error, you can't demote yourself."
        redirect_to group_path(@group)
      else
        @membership.destroy
        flash[:notice] = "Member has been removed from group."
        redirect_to group_path(@group)
      end
    else
      flash[:notice] = "You must be a group admin to do that."
      redirect_to group_path(@group)
    end
  end


  private
    def membership_params
      params.require(:membership).permit(:email)
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_membership
      @membership = @group.memberships.find_by email: params[:email]
    end

    def is_group_admin?(user)
      if user
        if @group.memberships.find_by(:email => user.email, :is_admin => true)
          return true
        end
      end
      return false
    end
end
