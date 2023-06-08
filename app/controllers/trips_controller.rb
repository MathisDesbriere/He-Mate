class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index, :new]

  def index
    @comments = Comment.where(trip_id: @trips.pluck(:id))
    @trips = policy_scope(Trip)
  end

  def like
    @trip = Trip.find(params[:id])
    @trip.like += 1
    @trip.save
    skip_authorization


    respond_to do |format|
      format.js { render json: { count: @trip.like } }
      format.html { redirect_to @trip } # 可能需要根據你的需求修改這個回應
      format.json { render json: { count: @trip.like } }
    end
  end

  def user_trips
    @user = User.find(params[:id])
    @comments = Comment.all

    if user_signed_in?
      @user = current_user
      @trips = @user.trips
      authorize @trips
    else
      redirect_to new_user_session_path, notice: "Please sign in to view your trips."
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @comments = Comment.all

    @user = current_user if user_signed_in?
    authorize @trip
  end

  def new
    @trip = Trip.new
    @marker = Marker.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @user = current_user if user_signed_in?
    @trip.images.attach(params[:trip][:images])
    @trip.user = current_user
    authorize @trip
    if @trip.save
      @marker = Marker.new(address: params[:other][:address], trip: @trip)
      @marker.save!
      redirect_to @trip, notice: "Trip was successfully created."
    else
      render :new
    end
  end

  def edit
    @user = current_user if user_signed_in?
    authorize @trip #line must be at the end of the method WARNING
  end

  def update
    @user = current_user if user_signed_in?
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
    authorize @trip #line must be at the end of the method WARNING
  end

  def destroy
    @user = current_user if user_signed_in?

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
