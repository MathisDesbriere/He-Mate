class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index, :new]

  def index
    @trips = Trip.all
    @trips = policy_scope(Trip)
  end


  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.images.attach(params[:trip][:images])
    @trip.user = current_user
    authorize @trip

    if @trip.save
      redirect_to @trip, notice: "Trip was successfully created."
    else
      render :new
    end
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
    params.require(:trip).permit(:title, :user, :like, :description, images: [])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
