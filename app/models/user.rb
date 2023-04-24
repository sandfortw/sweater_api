class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :api_key, presence: true, uniqueness: true

  before_validation :set_api_key


  private

  def set_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
  end
end