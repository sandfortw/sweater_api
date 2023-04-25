# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForecastService, type: :service do
  describe 'instance methods', :vcr do
    before do
      @location = { lat: 39.10713, lng: -84.50413 } # Cincinatti, Ohio
      @forecast = ForecastService.new({ lat: @location[:lat], lng: @location[:lng] }).get_forecast
    end
    describe '#get_forecast' do
      it 'should return data for current weather (current_weather)' do
        expect(@forecast).to be_a(Hash)
        expect(@forecast[:current][:last_updated]).to be_a(String)
        expect(@forecast[:current][:temp_f]).to be_a(Float)
        expect(@forecast[:current][:feelslike_f]).to be_a(Float)
        expect(@forecast[:current][:humidity]).to be_an(Integer)
        expect(@forecast[:current][:uv]).to be_a(Float)
        expect(@forecast[:current][:vis_miles]).to be_a(Float)
        expect(@forecast[:current][:condition][:text]).to be_a(String)
        expect(@forecast[:current][:condition][:icon]).to be_a(String)
      end
    end

    it 'should return forecast data for 5 days (daily_weather)' do
      expect(@forecast[:forecast]).to be_a(Hash)
      expect(@forecast[:forecast][:forecastday]).to be_an(Array)
      expect(@forecast[:forecast][:forecastday].size).to eq(5)
      expect(@forecast[:forecast][:forecastday].sample[:date]).to be_a(String)
      expect(@forecast[:forecast][:forecastday].sample[:astro][:sunrise]).to be_a(String)
      expect(@forecast[:forecast][:forecastday].sample[:astro][:sunset]).to be_a(String)
      expect(@forecast[:forecast][:forecastday].sample[:day][:maxtemp_f]).to be_a(Float)
      expect(@forecast[:forecast][:forecastday].sample[:day][:mintemp_f]).to be_a(Float)
      expect(@forecast[:forecast][:forecastday].sample[:day][:condition][:text]).to be_a(String)
      expect(@forecast[:forecast][:forecastday].sample[:day][:condition][:icon]).to be_a(String)
    end

    it 'should return hourly weather for the current day (hourly weather)' do
      expect(@forecast[:forecast][:forecastday].sample[:hour]).to be_an(Array)
      expect(@forecast[:forecast][:forecastday].sample[:hour].size).to be(24)
      expect(@forecast[:forecast][:forecastday].sample[:hour].sample[:time]).to be_a(String)
      expect(@forecast[:forecast][:forecastday].sample[:hour].sample[:temp_f]).to be_a(Float)
      expect(@forecast[:forecast][:forecastday].sample[:hour].sample[:condition][:text]).to be_a(String)
      expect(@forecast[:forecast][:forecastday].sample[:hour].sample[:condition][:icon]).to be_a(String)
    end
  end

  describe '#get_forecast_by_time', :vcr do
    let(:forecast_dt) { {:d=>"Dallas, TX", :t=>"2023-04-26", :h=>1} }
    it 'should return weather for the hour inputted' do
      service = ForecastService.new(forecast_dt).get_forecast_by_time
      expect(service[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a Numeric
      expect(service[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a String
    end
  end
end
