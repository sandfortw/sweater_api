module Api
  module V0
    class SessionsController < ApplicationController

      def create
        user = User.find_by(email: session_params[:email])
        if user && user.authenticate(session_params[:password])
          render json: UserSerializer.new(user).serializable_hash
        else
          render json: { error: "Bad email or password"}, status: :bad_request
        end
      end

      private
      def session_params
        json_payload = JSON.parse(request.body.read) unless @session_params
        @session_params ||= ActionController::Parameters.new(json_payload).permit(:email, :password)
      end
    end
  end
end