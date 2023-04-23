class ForecastFacade 

  def initialize(city_state)
    @city_state = city_state
  end

  def forecast
    lat_lng = GeocodingService.new(@city_state).get_coordinates
    ForecastService.new(lat_lng).get_forecast
  end
end