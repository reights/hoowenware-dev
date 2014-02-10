class TripsController < ApplicationController
  before_action :authorize_admin!, only: [:destroy]
  before_filter :authenticate_user!, except: [:show, :index]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.order('start_date ASC')
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      @trip.update(is_active: true)
      flash[:notice] = "Your trip has been created."
      redirect_to @trip
    else
      flash[:alert] = "Your trip has not been created."
      render "new"
    end
  end

  def show
    #set_trip
  end

  def edit
    #set_trip
  end

  def update
    #set_trip
    if @trip.update(trip_params)
      flash[:notice] = "Your trip has been updated."
      redirect_to @trip
    else
      flash[:alert] = "Your trip has not been updated."
      render "edit"
    end
  end

  def cancel
    @trip = Trip.find params[:trip_id]
    @trip.update(is_active: false)

    flash[:notice] = "Your trip has been cancelled."
    redirect_to trips_path
  end

  def reactivate
    @trip = Trip.find params[:trip_id]
    @trip.update(is_active: true)

    flash[:notice] = "Your trip has been reinstated."
    redirect_to trips_path
  end

  def destroy
    #set_trip
    @trip.destroy

    flash[:notice] = "This trip has been deleted."
    redirect_to trips_path
  end

  private
    def trip_params
      params.require(:trip).permit(:title, :hash_tag, :start_date, :end_date, 
                                  :location, :is_private, :hide_guestlist)
    end

    def set_trip
      @trip = Trip.find(params[:id])
   rescue ActiveRecord::RecordNotFound
     flash[:alert] = "The trip you were looking for could not be found."
     redirect_to trips_path
    end
end