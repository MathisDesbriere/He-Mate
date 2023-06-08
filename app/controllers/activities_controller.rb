class ActivitiesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  before_action :set_activity, only: [:show]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def search_tripadvisor_request
    url = URI("https://api.content.tripadvisor.com/api/v1/location/search?key=CEB729020CB9489E97FB95C01BCF13BD")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'

    response = http.request(request)
    puts response.read_body
  end

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
