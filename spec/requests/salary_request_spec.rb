require 'rails_helper'

RSpec.describe "Salary", type: :request do

  describe 'GET /api/v1/salaries?destination=chicago', :vcr do
    before do 
      get '/api/v1/salaries?destination=chicago'
      @salary = JSON.parse(response.body, symbolize_names: true)
    end

    it 'should return the correct information' do
      expect(@salary).to be_a Hash
      expect(@salary.keys).to contain_exactly(:data)
      expect(@salary[:data]).to be_a Hash
      expect(@salary[:data].keys).to contain_exactly(:id, :type, :attributes)
      expect(@salary[:data][:id]).to eq(nil)
      expect(@salary[:data][:type]).to eq("salaries")
      expect(@salary[:data][:attributes]).to be_a Hash
      expect(@salary[:data][:attributes].keys).to contain_exactly(:destination, :forecast, :salaries)
      expect(@salary[:data][:attributes][:destination]).to eq("Chicago")
      expect(@salary[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(@salary[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(@salary[:data][:attributes][:salaries]).to be_an Array
      expect(@salary[:data][:attributes][:salaries].sample).to be_a Hash
      expect(@salary[:data][:attributes][:salaries].sample[:title]).to be_a String
      expect(@salary[:data][:attributes][:salaries].sample[:min]).to be_a String
      expect(@salary[:data][:attributes][:salaries].sample[:min]).to match(/\$/)
      expect(@salary[:data][:attributes][:salaries].sample[:min]).to match(/\./)
      expect(@salary[:data][:attributes][:salaries].sample[:min]).to match(/\,/)
      expect(@salary[:data][:attributes][:salaries].sample[:max]).to be_a String
      expect(@salary[:data][:attributes][:salaries].sample[:max]).to match(/\$/)
      expect(@salary[:data][:attributes][:salaries].sample[:max]).to match(/\./)
      expect(@salary[:data][:attributes][:salaries].sample[:max]).to match(/\,/)
    end
  end
end