# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade do
  let(:good_payload) { { origin: 'Denver, CO', destination: 'Dallas, TX' } }
  let(:happy_facade) { RoadTripFacade.new(good_payload) }

  let(:bad_payload) { { origin: 'Denver, CO', destination: 'Madrid, Spain' } }
  let(:sad_facade) { RoadTripFacade.new(bad_payload) }


  describe '#road_trip' do
    it 'should return a hash with the following attributes (happy path)', :vcr do
      expect(happy_facade.road_trip).to be_a Hash
      expect(happy_facade.road_trip[:start_city]).to eq(good_payload[:origin])
      expect(happy_facade.road_trip[:end_city]).to eq(good_payload[:destination])
      expect(happy_facade.road_trip[:travel_time]).to be_a String
      expect(happy_facade.road_trip[:weather_at_eta]).to be_a Hash
      expect(happy_facade.road_trip[:weather_at_eta][:datetime]).to be_a String
      expect(happy_facade.road_trip[:weather_at_eta][:temperature]).to be_a Numeric
      expect(happy_facade.road_trip[:weather_at_eta][:condition]).to be_a String
    end

    it 'should return a hash with the following attributes (sad path)', :vcr do
      expect(sad_facade.road_trip).to be_a Hash
      expect(sad_facade.road_trip[:start_city]).to eq(bad_payload[:origin])
      expect(sad_facade.road_trip[:end_city]).to eq(bad_payload[:destination])
      expect(sad_facade.road_trip[:travel_time]).to eq('Impossible')
      expect(sad_facade.road_trip[:weather_at_eta]).to eq({})
    end
  end
end