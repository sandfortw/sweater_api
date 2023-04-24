require 'rails_helper'

RSpec.describe "Salary", type: :request do

  describe 'GET /api/v1/salaries?destination=chicago', :vcr do
    before do 
      get '/api/v1/salaries?destination=chicago'
      @salary = JSON.parse(response.body, symbolize_names: true)
    end

    it 'should return the correct information' do
      require 'pry'; binding.pry
    end
  end
end