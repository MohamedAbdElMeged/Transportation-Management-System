require 'rails_helper'
require 'webmock/rspec'

describe Trucks::RequestTrucks do
  describe '.call' do
    subject(:context) { described_class.call(params) }
    let(:params) do
      { url: "#{ENV['TRUCK_API_URL']}?page=1&", request_headers: {
        "API_KEY": ENV['TRUCK_API_KEY']
      } }
    end
    it 'should success' do
      expect(context.response_body.size).to eq(2)
      expect(context.response_headers&.[]('current-page')).to be_present
      expect(context.response_headers&.[]('current-page').to_i).to eq(1)
      expect(context.response_headers&.[]('total-count').to_i).to eq(10)

      expect(context.response_headers&.[]('total-count')).to be_present
    end
  end
end
