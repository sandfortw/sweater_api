# frozen_string_literal: true

class RouteService
  def initialize(payload)
    @payload = payload
  end

  def get_route
    response = conn.get do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:from] = @payload[:origin]
      req.params[:to] = @payload[:destination]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com/directions/v2/route')
  end
end
