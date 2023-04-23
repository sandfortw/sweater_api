class ForecastController < ApplicationController

  def show
    forecast = ForecastFacade.new(params[:location]).forecast
    render json: ForecastSerializer.new(forecast).serialize_forecast
  end

end