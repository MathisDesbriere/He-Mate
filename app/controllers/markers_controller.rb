class MarkersController < ApplicationController
  before_action :set_marker, only: [:destroy]

  def new
    @activity = Activity.find(params[:activity_id])
    @marker = Marker.new
    authorize @marker #line must be at the end of the method WARNING
  end

  def create
    @marker = Marker.new(marker_params)
    @marker.user = current_user
    authorize @marker #line must be at the end of the method WARNING
  end

  def destroy
    if @marker.destroy
      redirect_to markers_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
    authorize @marker #line must be at the end of the method WARNING
  end

  private

  def marker_params
    params.require(:marker).permit(:longitude, :latitude, :location)
  end

  def set_marker
    @marker = Marker.find(params[:id])
  end
end
