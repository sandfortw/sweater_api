
module Api
  module V0
    class SalariesController < ApplicationController
      def show
        forecast = ForecastFacade.new(params[:destination]).forecast
        salaries = SalaryFacade.new(params[:destination]).salaries
        # render json: ForecastSerializer.new(forecast).serializable_hash
      end
    end
  end
end