class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @trips = Trip.all
    @trips = policy_scope(Trip)
  end


  def show
    authorize @trip
  end

  def new
    @trip = Trip.new
    authorize @trip #line must be at the end of the method WARNING
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.image.attach(params[:trip][:image])
    @trip.user = current_user
    authorize @trip #line must be at the end of the method WARNING
  end

  def edit
    authorize @trip #line must be at the end of the method WARNING
  end

  def update
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
    authorize @trip #line must be at the end of the method WARNING
  end

  def destroy
    if @trip.destroy
      redirect_to trips_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
    authorize @trip #line must be at the end of the method WARNING
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :address, :description, :wifi, :TV, :parking, :air_conditioner, :image)
  end

  def set_trip
    @trip = trip.find(params[:id])
  end
end
