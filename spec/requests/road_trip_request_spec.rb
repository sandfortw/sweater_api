# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Road Trip', type: :request do

let(:user) {User.create!(email: 'realemail@example.com', password: 'abcde12345', password_confirmation: 'abcde12345') }
let(:valid_payload) { {origin: 'Denver, CO', destination: 'Dallas, TX', api_key: user.api_key} }
  describe 'POST /api/v0/road_trip', :vcr do
    context 'valid payload' do
      it 'should return a hash with travel information' do
        post '/api/v0/users', params: valid_payload.to_json
        returned = JSON.parse(response.body, symbolize_names: true)

        expect(returned[:data]).to be_a Hash
        expect(returned[:data][:id]).to be nil
        expect(returned[:data][:type]).to be "road_trip"
        expect(returned[:data][:attributes]).to contain_exactly(:start_city, :end_city, :travel_time, :weather_at_eta)
        expect(returned[:data][:attributes][:start_city]).to eq(valid_payload[:origin])
        expect(returned[:data][:attributes][:end_city]).to eq(valid_payload[:destination])
        expect(returned[:data][:attributes][:travel_time]).to be_a String
        expect(returned[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(returned[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
        expect(returned[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
        expect(returned[:data][:attributes][:weather_at_eta][:condition]).to be_a String
      end
    end

    context 'invalid payload' do
      it 'returns an unauthorized error when api key is invalid' do
        invalid_payload = {origin: 'Denver, CO', destination: 'Dallas, TX', api_key: 'hello world'}
        post '/api/v0/users', params: invalid_payload.to_json
        returned = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:unauthorized)
        expect(returned[:error]).to eq("Invalid API")
      end

      it 'returns invalid unprocessable entity when the route is impossible' do
        invalid_payload = {origin: 'Denver, CO', destination: 'Paris, France', api_key: user.api_key}
        post '/api/v0/users', params: invalid_payload.to_json
        returned = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(returned[:error]).to eq("Bad Route")
      end
    end
  end
end