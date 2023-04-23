require 'rails_helper'

RSpec.describe GeocodingService, type: :service do

  describe '#generate_forecast' do
    before do 
      @city = Faker::Address.full_address_as_hash(:city, :state_abbr)
      @coordinates = GeocodingService.new("#{@city[:city]}, #{@city[:state_abbr]}").get_coordinates
    end
    it 'should generate coordinates from string city', :vcr do
      expect(@coordinates).to be_a(Hash)
      expect(@coordinates[:lat]).to be_a(Float)
      expect(@coordinates[:lng]).to be_a(Float)
    end
  end
end