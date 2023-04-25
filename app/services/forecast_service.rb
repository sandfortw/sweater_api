# frozen_string_literal: true

class ForecastService
  def initialize(info)
    @info = info
  end

  def get_forecast
    response = conn.get do |req|
      req.url 'v1/forecast.json'
      req.params[:key] = ENV['WEATHER_API_KEY']
      req.params[:q] = "#{@info[:lat]}\,#{@info[:lng]}"
      req.params[:days] = '5'
      req.params[:aqi] = 'no'
      req.params[:alerts] = 'no'
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def get_forecast_by_unix
    response = conn.get do |req|
      req.url 'v1/forecast.json'
      req.params[:key] = ENV['WEATHER_API_KEY']
      req.params[:q] = @info[:d]
      req.params[:dt] = @info[:t]
      req.params[:hour] = @info[:h]
      req.params[:aqi] = 'no'
      req.params[:alerts] = 'no'
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'http://api.weatherapi.com')
  end
end
