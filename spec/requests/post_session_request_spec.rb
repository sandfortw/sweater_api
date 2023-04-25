# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions Post', type: :request do
  describe 'POST /api/v0/sessions', :vcr do
    it 'should create a new session if it matches a user in the system' do
      user = User.create!(email: 'realemail@example.com', password: 'abcde12345', password_confirmation: 'abcde12345')
      payload = { email: 'realemail@example.com', password: 'abcde12345' }

      post '/api/v0/sessions', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(returned).to be_a Hash
      expect(returned[:data]).to be_a Hash
      expect(returned[:data][:type]).to eq('users')
      expect(returned[:data][:id]).to eq(user.id.to_s)
      expect(returned[:data][:attributes].keys).to contain_exactly(:email, :api_key)
      expect(returned[:data][:attributes][:email]).to eq(user.email)
      expect(returned[:data][:attributes][:api_key]).to eq(user.api_key)
    end

    it 'should return an error if the password is incorrect' do
      user = User.create!(email: 'realemail@example.com', password: 'abcde12345', password_confirmation: 'abcde12345')
      payload = { email: 'realemail@example.com', password: 'password' }

      post '/api/v0/sessions', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(returned).to be_a Hash
      expect(returned[:error]).to eq("Bad email or password") 
      expect(response).to have_http_status(:bad_request)
    end

    it 'should return an error if the username is incorrect' do
      user = User.create!(email: 'realemail@example.com', password: 'abcde12345', password_confirmation: 'abcde12345')
      payload = { email: 'asdfasdf', password: 'abcde12345' }

      post '/api/v0/sessions', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(returned).to be_a Hash
      expect(returned[:error]).to eq("Bad email or password") 
      expect(response).to have_http_status(:bad_request)
    end


    it 'should return an error if the fields are blank' do
      user = User.create!(email: 'realemail@example.com', password: 'abcde12345', password_confirmation: 'abcde12345')
      payload = { email: '', password: '' }

      post '/api/v0/sessions', params: payload.to_json

      returned = JSON.parse(response.body, symbolize_names: true)
      expect(returned).to be_a Hash
      expect(returned[:error]).to eq("Bad email or password") 
      expect(response).to have_http_status(:bad_request)
    end
  end
end
