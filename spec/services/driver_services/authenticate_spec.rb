require 'rails_helper'
describe DriverServices::Authenticate do
  let!(:driver_instance) { create :driver, password: '12345678', password_confirmation: '12345678', email: 'mohamed@illa.com' }
  context 'when email and password are valid' do
    subject(:result) { described_class.new('mohamed@illa.com', '12345678') }
    subject(:driver) { result.call }
    it 'should return driver' do
      expect(driver).to eq(driver_instance)
    end
  end
  context "when email isn\'t valid" do
    subject(:result) { described_class.new('ahmed@illa.com', '12345678') }
    subject(:driver) { result.call }
    it 'should return driver' do
      expect(driver).not_to be_present
    end
  end
  context "when email is valid and password isn\'t valid" do
    subject(:result) { described_class.new('mohamed@illa.com', 'FakePassword') }
    subject(:driver) { result.call }
    it 'should return driver' do
      expect(driver).not_to be_present
    end
  end
end
