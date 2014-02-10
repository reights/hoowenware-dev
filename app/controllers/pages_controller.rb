class PagesController < ApplicationController
  def index
    @home_page = true
    @trips = Trip.order('start_date ASC').limit(4)
  end
end
