class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index, :new]

  def index
    @trips = policy_scope(Trip)
    @comments = Comment.new

  end

  def like
    @trip = Trip.find(params[:id])
    if @trip.like == nil
      @trip.like = 0
    else
      @trip.like += 1
    end
    @trip.save
    skip_authorization

    respond_to do |format|
      format.js { render json: { count: @trip.like } }
      format.html do
        session[:scroll_position] = params[:scroll_position]
        redirect_back(fallback_location: root_path)
      end
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
    @comments = Comment.new
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
    @trip.user = current_user
    authorize @trip
    if @trip.save
      @marker = Marker.new(address: params[:other][:address], trip: @trip)
      @marker.save!
      if @marker.latitude.present? && @marker.longitude.present?
        redirect_to @trip, notice: "Trip was successfully created."
      else
        redirect_to new_trip_path, notice: "We couldn't localize your place."
      end
    else
      render :new, status: :unprocessable_entity
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

    if @trip.comments.exists?
      @trip.comments.destroy_all
    end
    # @markers = Marker.where(trip_id: @trip.id)

    # if @markers.destroy_all
    if @trip.destroy
      redirect_to user_trips_path(@user), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
    # else
    #   render :new, status: :unprocessable_entity
    # end

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
