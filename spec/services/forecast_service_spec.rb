require 'rails_helper'

RSpec.describe ForecastService, type: :service do
  describe 'instance methods' do
    before do
      @location = {lat: 39.10713, lng: -84.50413} #Cincinatti, Ohio
      @service = ForecastService.new({lat: @location[:lat], lng: @location[:lng]})
    end
    describe '#get_current_weather', :vcr do
      it 'should return data for current weather' do
        current_weather = @service.get_current_weather
        expect(current_weather).to be_a(Hash)
        expect(current_weather[:current][:last_updated]).to be_a(String)
        expect(current_weather[:current][:temp_f]).to be_a(Float)
        expect(current_weather[:current][:feelslike_f]).to be_a(Float)
        expect(current_weather[:current][:humidity]).to be_an(Integer)
        expect(current_weather[:current][:uv]).to be_a(Float)
        expect(current_weather[:current][:vis_miles]).to be_a(Float)
        expect(current_weather[:current][:condition][:text]).to be_a(String)
        expect(current_weather[:current][:condition][:icon]).to be_a(String)
      end
    end

    describe '#get_daily_weather' do
      # it 'should return data for daily weather' do
      #   daily_weather = @service.get_daily_weather
      #   expect(daily_weather).to be_a(Hash)
      #   expect(daily_weather[:current][:last_updated]).to be_a(String)
      #   expect(daily_weather[:current][:temp_f]).to be_a(Float)
      #   expect(daily_weather[:current][:feelslike_f]).to be_a(Float)
      #   expect(daily_weather[:current][:humidity]).to be_an(Integer)
      #   expect(daily_weather[:current][:uv]).to be_a(Float)
      #   expect(daily_weather[:current][:vis_miles]).to be_a(Float)
      #   expect(daily_weather[:current][:condition][:text]).to be_a(String)
      #   expect(daily_weather[:current][:condition][:icon]).to be_a(String)
      # end
    end
  end
end