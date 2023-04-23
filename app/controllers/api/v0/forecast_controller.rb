class Api::V0::ForecastController < ApplicationController

  def show
    begin
      forecast = ForecastFacade.new(params[:location]).forecast
      render json: ForecastSerializer.new(forecast).serializable_hash
    rescue StandardError => e
      render json: { error: 'Bad Request' }, status: :bad_request
    end
  end

end