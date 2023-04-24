class SalaryFacade 

  def initialize(city_string)
    @city_string = city_string
  end

  def salaries
    # lat_lng = GeocodingService.new(@city_state).get_coordinates
    # ForecastService.new(lat_lng).get_forecast
    SalaryService.new(@city_string).get_salaries
  end
end