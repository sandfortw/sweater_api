# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/v0/users', :vcr do
    it 'should create a new user if all of the payload checks out' do
      payload = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      post "/api/v0/users", params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)

      expect(returned[:data]).to be_a Hash
      expect(returned[:data][:type]).to eq 'users'
      expect(returned[:data][:attributes][:email]).to eq payload["email"]
      expect(returned[:data][:attributes][:api_key]).to be_a String
    end
  end
end