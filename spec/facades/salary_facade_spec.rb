require 'rails_helper'

RSpec.describe SalaryFacade, type: :facade do
  describe '#salary', :vcr do
    let (:facade) { SalaryFacade.new("dallas") }
    let (:salaries) { facade.salaries }

    it 'should return a hash' do
      expect(salaries).to be_a(Hash)
    end

    it 'should return salary data', :vcr do
      expect(salaries[:salaries]).to be_a(Array)
      expect(salaries[:salaries].first[:job][:title]).to eq("Account Manager")
      expect(salaries[:salaries].first[:salary_percentiles]).to be_a(Hash)
      expect(salaries[:salaries].first[:salary_percentiles][:percentile_25]).to be_a(Float)
      expect(salaries[:salaries].first[:salary_percentiles][:percentile_75]).to be_a(Float)
    end

    it 'should return weather data', :vcr do
      expect(salaries).to be_a(Hash)
      expect(salaries[:current][:last_updated]).to be_a(String)
      expect(salaries[:current][:temp_f]).to be_a(Float)
      expect(salaries[:current][:feelslike_f]).to be_a(Float)
      expect(salaries[:current][:humidity]).to be_an(Integer)
      expect(salaries[:current][:uv]).to be_a(Float)
      expect(salaries[:current][:vis_miles]).to be_a(Float)
      expect(salaries[:current][:condition][:text]).to be_a(String)
      expect(salaries[:current][:condition][:icon]).to be_a(String)
    end
  end
end