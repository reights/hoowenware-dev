class InvitationsController < ApplicationController
  before_action :set_trip
  before_filter :set_invitation, only: [:new, :facebook, :google]
  before_filter :check_for_facebook_cred, only: [:facebook]
  before_filter :check_for_google_cred, only: [:google]
  before_filter :authenticate_user!
  before_filter :check_for_cancel, :check_for_delete_selected,
                :only => [:create]


  def create
    if params[:invitation]
      params[:invitation][:email].split(',').each do |email|
        @invitation = Invitation.create(trip_id: @trip.id, 
                                        email: email, 
                                        user_id: current_user.id)
      end
    else
      params[:email].each do |email|
        puts email
        @invitation = Invitation.create(trip_id: @trip.id, 
                                        email: email, 
                                        user_id: current_user.id)
      end
    end
    redirect_to new_trip_invitation_path(@trip)
  end

  def facebook
    friends_list = fb_data(current_user.facebook_acct.uid, 'fields=friends.fields(name,username)')
    @fbfriends = friends_list['friends']['data']
  end

  def google
    contact_list = google_contacts['feed']['entry']
    @contacts = Array.new
    contact_list.each do |contact|
      if contact['gd$email'] != nil
        @contacts << contact['gd$email'][0]['address'].gsub(/[']/,"")
      end
    end
    return @contacts.sort_by!{ |a| a }
  end

  private
    def invitation_params
      params.require(:invitation).permit(:email, :full_name, :avatar)
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def set_invitation
      @invitation = @trip.invitations.build
      @invitations = @trip.invitations
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

    def check_for_facebook_cred
      if current_user.has_facebook_acct?
        if current_user.facebook_acct.expires < Time.now.to_i
          redirect_to user_omniauth_authorize_path(:facebook)
        end
      else
        redirect_to user_omniauth_authorize_path(:facebook)
      end
    end

    def fb_data(user, endpoint)
      api_request = "https://graph.facebook.com/#{user}/?#{endpoint}"+
                    "&access_token=" + current_user.facebook_acct.token
      response = HttpMonkey.at(api_request).get
      return JSON.parse(response.body)
    end

    def check_for_google_cred
      if current_user.has_google_acct?
        if current_user.google_acct.expires < Time.now.to_i
          redirect_to user_omniauth_authorize_path(:google)
        end
      else
        redirect_to user_omniauth_authorize_path(:google)
      end
    end


  def google_contacts
    api_request = "https://www.google.com/m8/feeds/contacts/default/full/?"+
                  "alt=json&client_id=#{ENV['GOOGLE_CLIENT_ID']}" +
                  "&access_token=#{current_user.google_acct.token}" 
                  "&max-results=500"
    response = HttpMonkey.at(api_request).get
    return JSON.parse(response.body)
  end
end
