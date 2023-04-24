class SalaryService

  def initialize(info)
    @info = info
  end

  def get_forecast
    response = conn.get do |req|
      req.url "slug:#{@info}/salaries"
      req.params[:key] = ENV['WEATHER_API_KEY']
      req.params[:q] = "#{@info[:lat]}\,#{@info[:lng]}"
      req.params[:days] = '5'
      req.params[:aqi] = "no"
      req.params[:alerts] = "no"
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://api.teleport.org/api/urban_areas/")
  end
end