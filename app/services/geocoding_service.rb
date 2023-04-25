# frozen_string_literal: true

class GeocodingService
  def initialize(city_string)
    @city_string = city_string
  end

  def get_coordinates
    response = conn.get do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:location] = @city_string
    end
    json = JSON.parse(response.body, symbolize_names: true)
    json[:results].first[:locations].first[:latLng]
  end

  private

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1/address')
  end
end
