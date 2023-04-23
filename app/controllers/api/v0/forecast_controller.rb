# frozen_string_literal: true

module Api
  module V0
    class ForecastController < ApplicationController
      def show
        forecast = ForecastFacade.new(params[:location]).forecast
        render json: ForecastSerializer.new(forecast).serializable_hash
      rescue StandardError
        render json: { error: 'Bad Request' }, status: :bad_request
      end
    end
  end
end
