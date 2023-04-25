# frozen_string_literal: true

# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create!(email: 'newuser@example.com', password: 'abcde12345', password_confirmation: 'abcde12345')
  end

  describe 'validations' do
    it { should have_secure_password }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_confirmation_of(:password) }
  end

  describe '#set_api_key' do
    it 'sets the api_key before validation' do
      new_user = User.new(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
      expect(new_user.api_key).to be_nil
      new_user.valid?
      expect(new_user.api_key).not_to be_nil
    end
  end

  describe '.valid_key?' do
    it 'returns true if the provided key exists in the database' do
      key = user.api_key
      expect(User.valid_key?(key)).to be_truthy
    end

    it 'returns false if the provided key does not exist in the database' do
      invalid_key = 'invalid_key'
      expect(User.valid_key?(invalid_key)).to be_falsey
    end
  end

  describe '.email_exists?' do
    it 'returns true if the provided email exists in the database' do
      email = user.email
      expect(User.email_exists?(email)).to be_truthy
    end

    it 'returns false if the provided email does not exist in the database' do
      invalid_email = 'invalid@example.com'
      expect(User.email_exists?(invalid_email)).to be_falsey
    end
  end
end
