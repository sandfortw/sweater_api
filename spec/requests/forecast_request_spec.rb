require 'rails_helper'

RSpec.describe "Forecast", type: :request do

  describe 'GET /api/v0/forecast?location=[STRING]', :vcr do
    
    before do 
      get '/api/v0/forecast?location=cincinatti,oh'
      @forecast = JSON.parse(response.body, symbolize_names: true)
    end

    it 'should have id, type, and attribute properties' do
      expect(@forecast[:data][:id]).to eq(nil)
      expect(@forecast[:data][:type]).to eq('forecast')
      expect(@forecast[:data][:attributes].keys).to contain_exactly(:current_weather, :daily_weather, :hourly_weather)
    end

    it 'should have current_weather attributes' do
      current_weather = @forecast[:data][:attributes][:current_weather]
      expect(current_weather.keys).to contain_exactly(:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon)
      expect(current_weather[:last_updated]).to be_a(String)
      expect(current_weather[:temperature]).to be_a(Float)
      expect(current_weather[:feels_like]).to be_a(Float)
      expect(current_weather[:humidity]).to be_an(Integer)
      expect(current_weather[:uvi]).to be_a(Float)
      expect(current_weather[:visibility]).to be_a(Float)
      expect(current_weather[:condition]).to be_a(String)
      expect(current_weather[:icon]).to be_a(String)
    end

    it 'should have daily_weather attributes' do
      daily_weather = @forecast[:data][:attributes][:daily_weather]
      expect(daily_weather.size).to eq(5)
      expect(daily_weather.sample.keys).to contain_exactly(:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon)
      expect(daily_weather.sample[:date]).to be_a(String)
      expect(daily_weather.sample[:sunrise]).to be_a(String)
      expect(daily_weather.sample[:sunset]).to be_a(String)
      expect(daily_weather.sample[:max_temp]).to be_a(Float)
      expect(daily_weather.sample[:min_temp]).to be_a(Float)
      expect(daily_weather.sample[:condition]).to be_a(String)
      expect(daily_weather.sample[:icon]).to be_a(String)
    end

    it 'should have hourly_weather attributes' do
      hourly_weather = @forecast[:data][:attributes][:hourly_weather]
      expect(hourly_weather.size).to eq(24)
      expect(hourly_weather.sample.keys).to contain_exactly(:time, :temperature, :conditions, :icon)
      expect(hourly_weather.sample[:time]).to be_a(String)
      expect(hourly_weather.sample[:temperature]).to be_a(Float)
      expect(hourly_weather.sample[:conditions]).to be_a(String)
      expect(hourly_weather.sample[:icon]).to be_a(String)
    end

    it 'can handle a bad request', :vcr do
      get '/api/v0/forecast?location='
      bad_forecast = JSON.parse(response.body, symbolize_names: true)
      expect(bad_forecast).to eq({ error: 'Bad Request' })
    end
  end
end