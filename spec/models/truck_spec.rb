require 'rails_helper'

RSpec.describe Truck, type: :model do
  describe 'Create Truck' do
    context 'with valid name and type ' do
      let(:truck) { build :truck }
      it 'should be valid' do
        expect(truck.valid?).to eq(true)
      end
    end
    context 'with duplicate name' do
      let!(:truck1) { create :truck, name: 'CMYK' }
      let!(:truck2) { build :truck, name: 'CMYK' }
      it "shouldn\'t be valid" do
        expect(truck2.valid?).to eq(false)
      end
    end
  end
  describe 'Delete Truck' do
    let(:truck) { create :truck }
    before do
      REDIS.set('total_trucks_count_in_db', '5')
      truck.destroy
    end

    it 'should decrement count' do
      expect(REDIS.get('total_trucks_count_in_db').to_i).to eq(4)
    end
  end
end
