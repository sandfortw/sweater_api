class GeocodingService

  def initialize(city_string)
    @city_string = city_string
  end

  def get_coordinates
    Faraday.get
  end

  private

  def conn
    
  end
end