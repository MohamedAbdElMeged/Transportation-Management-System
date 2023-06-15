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
end
