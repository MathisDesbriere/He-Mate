module ApplicationHelper
  def pictures_tripadvisor(location_id)
    api_key = ENV['TRIPADVISOR_API_KEY']
    url = URI("https://api.content.tripadvisor.com/api/v1/location/#{location_id}/photos?key=#{api_key}&language=en")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'

    response = http.request(request)
    return response.read_body
  end
end
