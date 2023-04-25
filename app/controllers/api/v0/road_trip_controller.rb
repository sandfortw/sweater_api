module Api
  module V0
    class RoadTripController < ApplicationController
      def create
        if User.valid_key?(route_params[:api_key])
          route = RoadTripFacade.new(route_params).road_trip
          render json: RoadTripSerializer.new(route).serializable_hash
        else
          render json: { error: 'Invalid API' }, status: :unauthorized
        end
      end

      private

      def route_params
        json_payload = JSON.parse(request.body.read) unless @route_params
        @route_params ||= ActionController::Parameters.new(json_payload).permit(:origin, :destination, :api_key)
      end
    end
  end
end
