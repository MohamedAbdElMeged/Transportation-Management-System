require 'rails_helper'
describe TruckServices::GetById do
  let(:truck_instance) { create :truck }
  subject(:result) { described_class.new(truck_instance.id) }
  subject(:truck) { result.call }
  describe '.new' do
    it 'should initialize truck_id variable' do
      expect(result.truck_id).to match(truck_instance.id)
    end
  end
  describe '.call' do
    it 'should return truck' do
      expect(truck).to eq(truck_instance)
    end
  end
end
