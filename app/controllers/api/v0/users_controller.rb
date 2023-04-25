# frozen_string_literal: true

module Api
  module V0
    class UsersController < ApplicationController
      def create
        unless User.email_exists?(user_params[:email])
          user = User.create!(user_params) 
          render json: UserSerializer.new(user).serializable_hash, status: 201
        else
          render json: { error: "Email Already in System"}, status: :bad_request
        end
      rescue => e
        render json: { error: e.message }, status: :bad_request
      end

      private

      def user_params
        json_payload = JSON.parse(request.body.read) unless @_user_params
        @_user_params ||= ActionController::Parameters.new(json_payload).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
