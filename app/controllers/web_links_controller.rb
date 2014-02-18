class WebLinksController < ApplicationController
  before_action :set_user
  before_filter :authenticate_user!, except: [:show]


  def new
    @web_link = @user.web_links.build
  end

  def create
    #set_user
    @web_link = @user.web_links.build(web_link_params)
    if @web_link.save
      flash[:notice] = "Link has been added to profile."
      redirect_to user_path(@user)
    else
      flash[:alert] = "Link has not been added to profile."
      redirect_to user_path(@user)
    end
  end

  def destroy
    @web_link = WebLink.find(params[:id])
    if @user.id == @web_link.user_id
      @web_link.destroy
      flash[:notice] = "Link has been removed."
      redirect_to user_path(@user)
    else
      flash[:alert] = "You must be the account owner to do that."
      redirect_to user_path(@user)
    end
  end

  private 
    def web_link_params
      params.require(:web_link).permit(:user_id, :url)
    end

    def set_user
      @user = User.find(current_user.id)
    end

end
