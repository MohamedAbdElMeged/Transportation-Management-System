require 'rails_helper'

describe Trucks::ConstructUrl do
  describe '.call' do
    subject(:context) { described_class.call(params) }
    let(:params) { { params: { page: 1 } } }
    let(:expected_url) { "#{ENV['TRUCK_API_URL']}?page=1&" }
    it 'should set next_page parameter' do
      expect(context.url).to match(expected_url)
    end
  end
end
