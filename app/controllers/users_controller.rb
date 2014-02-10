class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    #set_user
  end

  def edit
    #set_user
  end

  def update
    #set_user
    if @user.update(user_params)
      @user.update(profile_updated: true)
      flash[:notice] = "Your profile has been updated."
      render "edit"
    else
      flash[:alert] = "Your profile has not been updated."
      render "edit"
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name,
                                    :gender, :status, :zip_code, :mobile_number, 
                                    :skype_id, :dietary_pref, :roommate_pref)
    end
    def set_user
      @user = User.find(params[:id])
   rescue ActiveRecord::RecordNotFound
     flash[:alert] = "The profile you were looking for could not be found."
     redirect_to root_path
    end
end
