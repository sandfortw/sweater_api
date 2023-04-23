class UsersController < ApplicationController
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end