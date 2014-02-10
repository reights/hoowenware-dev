class PagesController < ApplicationController
  def index
    @trips = Trip.order('start_date ASC').limit(4)
  end
end
