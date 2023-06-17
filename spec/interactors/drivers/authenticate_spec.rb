require 'rails_helper'

describe Drivers::Authenticate do
  describe '.call' do
    subject(:context) { described_class.call(params) }
    context 'when sending password only' do
      let(:params) { { password: '123456789' } }
      it 'should fail' do
        expect(context).to be_a_failure
      end
    end
    context 'when sending valid email and password' do
      let!(:driver) { create :driver, email: 'test@illa.com', password: '123456789', password_confirmation: '123456789' }
      let(:params) { { email: 'test@illa.com', password: '123456789' } }
      it 'should success and return the driver' do
        expect(context.driver).to eq(driver)
      end
    end
    context 'when sending valid email but invalid password' do
      let!(:driver) { create :driver, email: 'test@illa.com', password: '123456789', password_confirmation: '123456789' }
      let(:params) { { email: 'test@illa.com', password: 'fake password' } }
      it 'should fail and return message' do
        expect(context).to be_a_failure
        expect(context.message).to  be_present
        expect(context.message).to  match('invalid email/password')
      end
    end
  end
end
