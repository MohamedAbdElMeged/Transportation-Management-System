require 'rails_helper'

describe Trucks::AssignTruck do
  describe '.call' do
    subject(:context) { described_class.call(params) }
    context 'pass driver without truck' do
      let!(:driver) { create :driver }
      let!(:params) { { driver: driver } }
      it 'should fail' do
        expect(context).to be_a_failure
        expect(context.message).to  be_present
        expect(context.message).to  match('driver and truck should be sent')
      end
    end
    context 'pass driver and truck' do
      let!(:driver) { create :driver }
      let!(:truck) { create :truck }
      let!(:params) { { driver: driver, truck: truck } }
      it 'should success' do
        expect(context.drivers_truck).to be_present
        expect(context.drivers_truck.driver).to eq(driver)
        expect(context.drivers_truck.truck).to eq(truck)
      end
    end
  end
end
