class ActivitiesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index]


  def index
    @activities = policy_scope(Activity)
  end

  def show
    authorize @activity
  end

  def new
    @attractions = JSON.parse(search_tripadvisor(params[:lat], params[:long]))
    @attractions = @attractions["data"]
    @activity = Activity.new
    authorize @activity #line must be at the end of the method WARNING
  end

  def create
    activities_params = params[:activity]["activities"]

    activities_params.each do |attraction_id, attraction_details|
      next unless attraction_details['selected'] == '1' # Vérifier si l'attraction est sélectionnée

      activity = Activity.new(
        title: attraction_details['name'],
        address: attraction_details['address']
      )
      activity.picture = attraction_details['picture'] if attraction_details['picture'].present?
      authorize activity
      if activity.save
        redirect_to activities_path, status: :see_other
      else
        render :new, status: :unprocessable_entity
        break
      end
    end
  end

  def edit
    authorize @edit
  end

  def update
    @activity.update(activity_params)
    redirect to activity_path(@activity)
    authorize @activity
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
    params.require(:activity).permit(:title, :trip, :address, :attraction_id)
  end

  def set_activity
    @activity = activity.find(params[:id])
  end

  def search_tripadvisor(lat, long)
    api_key = ENV['TRIPADVISOR_API_KEY']
    url = URI("https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=#{lat}%2C#{long}&key=#{api_key}&category=attractions&language=en")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'

    response = http.request(request)
    return response.read_body
  end

end
