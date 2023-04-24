class Api::V0::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user).serializable_hash
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def user_params
    json_payload = JSON.parse(request.body.read)
    ActionController::Parameters.new(json_payload).permit(:email, :password, :password_confirmation)
  end
end