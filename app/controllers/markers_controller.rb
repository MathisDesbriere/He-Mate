class MarkersController < ApplicationController
  before_action :set_marker, only: [:destroy]


  def index
    @markers = policy_scope(Marker)
    @coordinates = @markers.where.not(trip_id: nil).geocoded.map do |marker|
      {
        lat: marker.latitude,
        lng: marker.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { marker: marker }),
        marker_html: render_to_string(partial: "marker", locals: { marker: marker })
      }
    end
  end

  def new
    @marker = Marker.new
    authorize @marker #line must be at the end of the method WARNING
  end

  def create
    @marker = Marker.new(marker_params)
    if @marker.save
      if @marker.latitude.present? && @marker.longitude.present?
        redirect_to new_activity_path(marker: @marker, lat: @marker.latitude, long: @marker.longitude)
      else
        redirect_to new_marker_path, notice: "We couldn't localize your place."
      end
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:marker).permit(:longitude, :latitude, :address)
  end

  def set_marker
    @marker = Marker.find(params[:id])
  end
end
