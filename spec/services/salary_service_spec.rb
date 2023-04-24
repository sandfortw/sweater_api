require 'rails_helper'

RSpec.describe SalaryService, type: :service do

  describe '#generate_forecast' do
    before do 
      @salaries = SalaryService.new('dallas').get_salaries
    end
    it 'should generate salaraies from string city', :vcr do
      expect(@salaries).to be_a(Hash)
      expect(@salaries[:salaries]).to be_a(Array)
      expect(@salaries[:salaries].first[:job][:title]).to eq("Account Manager")
      expect(@salaries[:salaries].first[:salary_percentiles]).to be_a(Hash)
      expect(@salaries[:salaries].first[:salary_percentiles][:percentile_25]).to be_a(Float)
      expect(@salaries[:salaries].first[:salary_percentiles][:percentile_75]).to be_a(Float)
    end
  end
end