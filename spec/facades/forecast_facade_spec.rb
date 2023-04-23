require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do

  before do 
    @facade = ForecastFacade.new("dallas, tx")
  end
  
  describe '#forecast', :vcr do
    it 'should return a hash of forecast data' do
      forecast_hash = @facade.forecast
      expect(forecast_hash).to be_a(Hash)
    end
  end
end