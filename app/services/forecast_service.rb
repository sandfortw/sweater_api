class ForecastService

  def initialize(info)
    @info = info
  end

  def generate_forecast
    get_current_weather
  end


  def get_current_weather
    response = conn.get do |req|
      req.url 'v1/forecast.json'
      req.params[:key] = ENV['WEATHER_API_KEY']
      req.params[:q] = "#{@info[:lat]}\,#{@info[:lng]}"
      req.params[:days] = '1'
      req.params[:aqi] = "no"
      req.params[:alerts] = "no"
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end



  private

  def conn
    Faraday.new(url: "http://api.weatherapi.com")
  end
end