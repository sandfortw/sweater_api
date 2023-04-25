# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodingService, type: :service do
  describe '#generate_forecast' do
    before do
      @coordinates = GeocodingService.new('cincinatti, oh').get_coordinates
    end
    it 'should generate coordinates from string city', :vcr do
      expect(@coordinates).to be_a(Hash)
      expect(@coordinates[:lat]).to be_a(Float)
      expect(@coordinates[:lng]).to be_a(Float)
    end
  end
end
