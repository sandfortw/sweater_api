class ForecastFacade 

  def initialize(city_state)
    @city_state = city_state
  end

  def forecast
    raise ArgumentError, "Genre cannot be empty or nil" if @city_state.nil? || @city_state.empty?
    ForecastService.new.(@city_state).generate_forecast
  end
end