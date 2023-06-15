require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe "Create Driver" do
    context "create driver with valid email and password" do
      let(:driver) {build :driver, email: "mohamed@illa.com",password: "1234567",password_confirmation: "1234567" }
      it "should be valid" do
        expect(driver.valid?).to eq(true)
      end
    end
    context "create driver with duplicate email" do
      let!(:driver1) {create :driver, email: "mohamed@illa.com",password: "1234567",password_confirmation: "1234567" }
      let(:driver2) {build :driver, email: "mohamed@illa.com",password: "1234567",password_confirmation: "1234567" }
      it "shouldn\'t be valid" do
        expect(driver2.valid?).to eq(false)
      end
    end
    context "create driver without email" do
      let(:driver) {build :driver, email: nil,password: "1234567",password_confirmation: "1234567" }
      it "shouldn\'t be valid" do
        expect(driver.valid?).to eq(false)
      end
    end
    context "create driver but password not equal password_confirmation" do
      let(:driver) {build :driver, email: "mohamed@illa.com",password: "1234567",password_confirmation: "sdvdsdsv" }
      it "shouldn\'t be valid" do
        expect(driver.valid?).to eq(false)
      end
    end

  end
  
end
