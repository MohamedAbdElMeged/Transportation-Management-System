require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe 'Create Driver' do
    context 'with valid email and password' do
      let(:driver) { build :driver, email: 'mohamed@illa.com', password: '1234567', password_confirmation: '1234567' }
      it 'should be valid' do
        expect(driver.valid?).to eq(true)
      end
    end
    context 'with duplicate email' do
      let!(:driver1) { create :driver, email: 'mohamed@illa.com', password: '1234567', password_confirmation: '1234567' }
      let(:driver2) { build :driver, email: 'mohamed@illa.com', password: '1234567', password_confirmation: '1234567' }
      it "shouldn\'t be valid" do
        expect(driver2.valid?).to eq(false)
      end
    end
    context 'without email' do
      let(:driver) { build :driver, email: nil, password: '1234567', password_confirmation: '1234567' }
      it "shouldn\'t be valid" do
        expect(driver.valid?).to eq(false)
      end
    end
    context "with password doesn\'t equal password_confirmation" do
      let(:driver) { build :driver, email: 'mohamed@illa.com', password: '1234567', password_confirmation: 'sdvdsdsv' }
      it "shouldn\'t be valid" do
        expect(driver.valid?).to eq(false)
      end
    end
  end
end
