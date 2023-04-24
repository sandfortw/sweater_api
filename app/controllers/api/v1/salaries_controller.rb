
module Api
  module V0
    class SalariesController < ApplicationController
      def show
        forecast = ForecastFacade.new(params[:location]).forecast
        render json: ForecastSerializer.new(forecast).serializable_hash
      end
    end
  end
end