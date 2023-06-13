class TripsController < ApplicationController
  after_action :verify_authorized, except: [:index, :user_trips], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :user_trips], unless: :skip_pundit?

  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index, :new]

  def index
    @trips = policy_scope(Trip)
    @comments = Comment.new
  end

  def like
    @trip = Trip.find(params[:id])
    @trip.like ||= 0
    @trip.like += params[:count].to_i

    skip_authorization

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_path(@trip.like) }
        format.json { render json: { count: @trip.like } }
      else
        format.html { render "trips/index", status: :unprocessable_entity }
        format.json { render json: { error: "Failed to update like count" }, status: :unprocessable_entity }
      end
    end
  end

  def user_trips
    @trips = policy_scope(Trip)
    @user = User.find(params[:id])
    @comments = Comment.all

    if user_signed_in?
      @user = current_user
      @trips = policy_scope(Trip, policy_scope_class: TripPolicy::UserTripsScope)
      @comments = Comment.new
    else
      redirect_to new_user_session_path, notice: "Please sign in to view your trips."
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @comments = Comment.all
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
      @marker = Marker.new(address: params[:other][:address], trip: @trip, user: current_user)
      @marker.save!
      if @marker.latitude.present? && @marker.longitude.present?
        redirect_to new_activity_path(marker: @marker, trip: @trip, lat: @marker.latitude, long: @marker.longitude)
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
    redirect_to user_trips_path(current_user)
    authorize @trip #line must be at the end of the method WARNING
  end

  def destroy
    @trip.comments.destroy_all if @trip.comments.exists?
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
    params.require(:trip).permit(:title, :user, :count, :like, :description, images: [])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
