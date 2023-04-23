class ForecastController < ApplicationController

  def create
    # coordinates = CoordinatesFacade.new.find_by_city(params[:location]) #should be latitude and longitude
    forecast = ForecastFacade.new(params[:location]).forecast
    render json: ForecastSerializer.new(forecast).serialize_forecast

  end

end