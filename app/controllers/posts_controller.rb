class PostsController < ApplicationController
  before_action :set_trip
  before_filter :authenticate_user!


  def create
    @post = @trip.posts.build(:user_id => current_user.id, 
                              :message => params[:post][:message])
    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to @trip
    else
      flash[:alert] = "Your post has not been created."
      redirect_to @trip
    end
  end


  private

    def post_params
      params.require(:post).permit(:message)
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def set_post
      @post = Post.find(params[:id])
   rescue ActiveRecord::RecordNotFound
     flash[:alert] = "The post you were looking for could not be found."
     redirect_to @trip
    end
end
