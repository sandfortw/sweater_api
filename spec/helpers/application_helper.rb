require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '.format_dollars' do
    it 'formats floats into a human readable dollar format' do
      expect(ApplicationHelper.format_dollars(12_341_234.424234)).to eq("$12,341,234.42")
    end
  end
end