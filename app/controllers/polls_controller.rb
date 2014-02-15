class PollsController < ApplicationController
  before_action :set_trip
  before_filter :check_for_cancel, :only => [:create, :update]

  def dates
    @poll = @trip.polls.build
  end

  def locations
    @poll = @trip.polls.build
  end

  def create
    @poll = @trip.polls.build(poll_params)
    if @poll.save
      @poll.update(is_active: true)
      flash[:notice] = "Your poll has been created."
      redirect_to edit_trip_path(@trip)
    else
      flash[:alert] = "Your poll has not been created."
      render "new"
    end
  end

  private
    def poll_params
      params.require(:poll).permit(:poll_type, :title, :start_date, :end_date, 
                                    :location, :notes, :expires)
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
end
