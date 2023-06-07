class MarkersController < ApplicationController
  before_action :set_marker, only: [:destroy]


  def index
    @markers = Marker.all
    @markers = policy_scope(Marker)
    @coordinates = @markers.geocoded.map do |marker|
      {
        lat: marker.latitude,
        lng: marker.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {marker: marker}),
        marker_html: render_to_string(partial: "marker", locals: {marker: marker})
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
      redirect_to markers_path, notice: 'Marker was successfully created.'
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
