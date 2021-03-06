class FilesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]
  def new
    @trip  = Trip.new
    asset = @trip.assets.build
    render partial: "files/form",
            locals: { number: params[:number].to_i }
  end

  def show
    asset = Asset.find(params[:id])
    if can?(:view, asset.ticket.project)
      send_file asset.asset.path,
        filename:     asset.asset_identifier,
        content_type: asset.content_type
    else
      flash[:alert] = "The asset you were looking for could not be found."
      redirect_to root_path
    end
  end

end
