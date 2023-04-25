module Api
  module V0
    class SessionsController < ApplicationController

      def create

        user = User.find_by(email: session_params[:email])
        if user && user.authenticate(session_params[:password])
          render json: UserSerializer.new(user).serializable_hash
        end
      rescue => e
        render json: { error: e.message }, status: :bad_request
      end

      private
      def session_params
        json_payload = JSON.parse(request.body.read) unless @session_params
        @session_params ||= ActionController::Parameters.new(json_payload).permit(:email, :password)
      end
    end
  end
end