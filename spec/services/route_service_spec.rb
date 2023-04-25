# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RouteService, type: :service do

  describe 'normal route', :vcr do
    let(:payload) { {origin: "Denver, CO", destination: "Dallas, TX"} }
    let(:route) { RouteService.new(payload).get_route }
    it 'should return a response with the following fields' do
      expect(route[:info][:statuscode]).to eq(0)
      expect(route[:route][:realTime]).to be_an(Integer)
      expect(route[:route][:formattedTime]).to be_a(String)
    end
  end

  describe 'bad route', :vcr do
    let(:payload) { {origin: "Denver, CO", destination: "Madrid, Spain"} }
    let(:route) { RouteService.new(payload).get_route }
    it 'should return a response with the following fields' do
      expect(route[:info][:statuscode]).to eq(402)
    end
  end
end