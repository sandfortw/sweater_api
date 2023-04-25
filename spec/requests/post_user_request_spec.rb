# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/v0/users', :vcr do
    it 'should create a new user if all of the payload checks out' do
      payload = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v0/users', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)

      expect(returned[:data]).to be_a Hash
      expect(returned[:data][:type]).to eq 'users'
      expect(returned[:data][:attributes][:email]).to eq(payload[:email])
      expect(returned[:data][:attributes][:api_key]).to be_a String
    end

    it 'should return some error message if there is a user already in the system with that email' do
      User.create!(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')
      payload = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v0/users', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:conflict)
      expect(returned[:error]).to be_a String
      expect(returned[:error].include?('Email Already in System')).to be(true)
    end

    it 'should return some error message if the payloads passwords do not match' do
      payload = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password1'
      }

      post '/api/v0/users', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(returned[:error]).to be_a String
      expect(returned[:error].include?("Password confirmation doesn't match Password")).to be(true)
    end

    it 'should return a different error if a field is blank' do
      payload = {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v0/users', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(returned[:error]).to be_a String
      expect(returned[:error].include?("Email can\'t be blank")).to be(true)
    end
  end
end
