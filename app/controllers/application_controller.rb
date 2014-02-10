class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private
    def authorize_admin!
      authenticate_user!

      unless current_user.is_admin?
        flash[:alert] = "Sorry, you have to be an admin to do that."
        redirect_to root_path
      end
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, 
                                                              :email, :password, 
                                                              :password_confirimation) }
    end
end
