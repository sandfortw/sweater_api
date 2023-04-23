# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  describe '#forecast', :vcr do
    let(:facade) { ForecastFacade.new('dallas, tx') }
    let(:forecast) { facade.forecast }
    it 'should return a hash' do
      expect(forecast).to be_a(Hash)
    end

    it 'should return data for current weather (current_weather)' do
      expect(forecast).to be_a(Hash)
      expect(forecast[:current][:last_updated]).to be_a(String)
      expect(forecast[:current][:temp_f]).to be_a(Float)
      expect(forecast[:current][:feelslike_f]).to be_a(Float)
      expect(forecast[:current][:humidity]).to be_an(Integer)
      expect(forecast[:current][:uv]).to be_a(Float)
      expect(forecast[:current][:vis_miles]).to be_a(Float)
      expect(forecast[:current][:condition][:text]).to be_a(String)
      expect(forecast[:current][:condition][:icon]).to be_a(String)
    end

    it 'should return forecast data for 5 days (daily_weather)' do
      expect(forecast[:forecast]).to be_a(Hash)
      expect(forecast[:forecast][:forecastday]).to be_an(Array)
      expect(forecast[:forecast][:forecastday].size).to eq(5)
      expect(forecast[:forecast][:forecastday].sample[:date]).to be_a(String)
      expect(forecast[:forecast][:forecastday].sample[:astro][:sunrise]).to be_a(String)
      expect(forecast[:forecast][:forecastday].sample[:astro][:sunset]).to be_a(String)
      expect(forecast[:forecast][:forecastday].sample[:day][:maxtemp_f]).to be_a(Float)
      expect(forecast[:forecast][:forecastday].sample[:day][:mintemp_f]).to be_a(Float)
      expect(forecast[:forecast][:forecastday].sample[:day][:condition][:text]).to be_a(String)
      expect(forecast[:forecast][:forecastday].sample[:day][:condition][:icon]).to be_a(String)
    end

    it 'should return hourly weather for the current day (hourly weather)' do
      expect(forecast[:forecast][:forecastday].sample[:hour]).to be_an(Array)
      expect(forecast[:forecast][:forecastday].sample[:hour].size).to be(24)
      expect(forecast[:forecast][:forecastday].sample[:hour].sample[:time]).to be_a(String)
      expect(forecast[:forecast][:forecastday].sample[:hour].sample[:temp_f]).to be_a(Float)
      expect(forecast[:forecast][:forecastday].sample[:hour].sample[:condition][:text]).to be_a(String)
      expect(forecast[:forecast][:forecastday].sample[:hour].sample[:condition][:icon]).to be_a(String)
    end
  end
end
