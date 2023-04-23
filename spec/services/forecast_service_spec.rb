require 'rails_helper'

RSpec.describe ForecastService, type: :service do

  describe '#generate_forecast' do
    describe 'returning a forecast', :vcr do
      before do
        @forecast = ForecastService.new({lat: 38.892062, lng: -77.019912}).generate_forecast
      end
      it 'should have data for current weather' do
        expect(@forecast).to be_a(Hash)
      end

      it 'should have data for daily weather' do

      end

      it 'should have data for hourly weather' do

      end
    end

    describe 'sad_path', :vcr do

    end
  end
end