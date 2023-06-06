class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @activitys = Activity.all
    @activitys = policy_scope(Activity)
  end

  def show
    authorize @activity
  end

  def new
    @activity = Activity.new
    authorize @activity #line must be at the end of the method WARNING
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.image.attach(params[:activity][:image])
    @activity.user = current_user
    authorize @activity #line must be at the end of the method WARNING
  end

  def destroy
    if @activity.destroy
      redirect_to activities_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
    authorize @activity
  end

  private

  def activity_params
    params.require(:activity).permit(:title, :link)
  end

  def set_activity
    @activity = activity.find(params[:id])
  end
end
