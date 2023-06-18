require 'rails_helper'

describe Trucks::SetTotalDbTrucksInRedis do
  describe '.call' do
    subject(:context) { described_class }

    let(:params) { { response_body_count: 25, response_headers: { 'current-page' => 1 } } }
    let(:context_response) { subject.call }
    before do
      Truck.create([{ name: 'hi1', truck_type: 'test_type1' }, { name: 'hi2', truck_type: 'test_type2' }])
    end

    it 'should save total_trucks_count_in_db in redis with value = 2' do
      context_response
      expect(context_response.success?).to eq(true)
      expect(REDIS.get('total_trucks_count_in_db').to_i).to eq(2)
    end
  end
end
