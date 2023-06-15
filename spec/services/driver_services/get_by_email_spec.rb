require 'rails_helper'

describe DriverServices::GetByEmail do
  let!(:driver_instance) { create :driver }
  let(:email) { driver_instance.email }
  subject(:result) { described_class.new(email) }
  subject(:driver) { result.call }
  describe '.new' do
    it 'should initialize email variable' do
      expect(result.email).to match(email)
    end
  end
  describe '.call' do
    it 'should return driver' do
      expect(driver).to eq(driver_instance)
    end
  end
end
