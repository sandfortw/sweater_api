require 'rails_helper'

RSpec.describe GeocodingService, type: :service do

  describe '#generate_forecast' do
    before do 
      @coordinates = GeocodingService.new('cincinatti, oh').generate_forecast
    end
    it 'should generate coordinates from string city', :vcr do
      expect(@coordinates).to be_a(Hash)
    end
  end
end