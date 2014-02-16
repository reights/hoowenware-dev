class InvitationsController < ApplicationController
  before_action :set_trip
  before_filter :check_for_cancel, :check_for_delete_selected,
                :only => [:create]

  def new
    @invitation = @trip.invitations.build
    @invitations = @trip.invitations
  end
  
  def create
    params[:invitation][:email].split(',').each do |email|
      @invitation = Invitation.create(trip_id: @trip.id, 
                                        email: email, 
                                        user_id: current_user.id)
    end
    redirect_to new_trip_invitation_path(@trip)
  end

  private
    def invitation_params
      params.require(:invitation).permit(:email, :full_name, :avatar)
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def check_for_cancel
      if params[:commit] == "Cancel"
        flash[:notice] = "Your changes have been cancelled."
        redirect_to edit_trip_path(@trip)
      end
    end

    def check_for_delete_selected
      if params[:commit] == "Delete selected"
        if current_user == @trip.user or current_user.is_admin?
          params[:email].each do |email|
            @invitation = Invitation.find_by(trip_id: @trip.id, email: email)
            @invitation.destroy
          end
          flash[:notice] = "These invites have been chancelled."
          redirect_to new_trip_invitation_path(@trip)
        else
          flash[:notice] = "You must be the trip owner to do that."
          redirect_to new_trip_invitation_path(@trip)
        end

      end
    end
end
