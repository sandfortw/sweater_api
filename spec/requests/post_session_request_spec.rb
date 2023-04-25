# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions Post', type: :request do
  describe 'POST /api/v0/sessions', :vcr do
    it 'should create a new session if it matches a user in the system' do
      user = User.create!(email: 'realemail@example.com', password: 'abcde12345', password_confirmation: 'abcde12345')
      payload = { email: 'realemail@example.com', password: 'abcde12345' }

      post '/api/v0/sessions', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(returned).to be_a Hash
      expect(returned[:data]).to be_a Hash
      expect(returned[:data][:type]).to eq('users')
      expect(returned[:data][:id]).to eq(user.id.to_s)
      expect(returned[:data][:attributes].keys).to contain_exactly(:email, :api_key)
      expect(returned[:data][:attributes][:email]).to eq(user.email)
      expect(returned[:data][:attributes][:api_key]).to eq(user.api_key)
    end
  end
end
