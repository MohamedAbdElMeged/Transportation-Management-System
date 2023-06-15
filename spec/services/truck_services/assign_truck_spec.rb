require 'rails_helper'
describe TruckServices::AssignTruck do
  let(:driver) { create :driver }
  let(:truck) { create :truck }
  subject(:result) { described_class.new(driver, truck) }
  subject(:drivers_truck) { result.call }
  describe '.new' do
    it 'should initialize driver and truck variables' do
      expect(result.driver).to eq(driver)
      expect(result.truck).to eq(truck)
    end
  end
  describe '.call' do
    it 'should assign truck to driver successfully' do
      expect(drivers_truck).to be_present
      expect(drivers_truck.driver).to eq(driver)
      expect(drivers_truck.truck).to eq(truck)
      expect(driver.trucks.size).to eq(1)
    end
  end
end
