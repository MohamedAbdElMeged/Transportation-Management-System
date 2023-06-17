require 'rails_helper'

RSpec.describe 'Api::V1::DriversController', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:driver, 10)
      get '/api/v1/drivers'
    end
    it 'returns http success' do
      expect(json['data'].size).to eq(10)
      expect(response.status).to eq(200)
    end
  end
  describe 'POST /drivers' do
    context 'with valid_params' do
      let(:email) { Faker::Internet.email }
      before do
        post '/api/v1/drivers', params: { driver:
                {
                  email: email,
                  password: '12345678',
                  password_confirmation: '12345678'
                } }
      end
      it 'returns http created' do
        expect(response.status).to eq(201)
      end
      it 'create driver successfully' do
        expect(Driver.first.email).to eq(email)
      end
    end
    context 'with duplicate_email' do
      let(:email) { Faker::Internet.email }
      let!(:first_driver) { create :driver, email: email }
      before do
        post '/api/v1/drivers', params: { driver:
                {
                  email: email,
                  password: '12345678',
                  password_confirmation: '12345678'
                } }
      end
      it 'returns http unprocessable_entity' do
        expect(response.status).to eq(422)
      end

      it 'return validation error' do
        expect(json['email']).to match(['has already been taken'])
      end
    end
    context 'with invalid email' do
      before do
        post '/api/v1/drivers', params: { driver: {
          email: 'test',
          password: '12345678',
          password_confirmation: '12345678'

        } }
      end
      it 'returns http unprocessable_entity' do
        expect(response.status).to eq(422)
      end

      it 'return validation error' do
        expect(json['email']).to match(['is invalid'])
      end
    end
  end

  describe 'POST /drivers/login' do
    let(:email) { Faker::Internet.email }
    let!(:driver) { create :driver, email: email }
    context 'with valid email and password' do
      before do
        post '/api/v1/drivers/login', params: { driver:
                {
                  email: email,
                  password: '123456789'

                } }
      end
      it 'returns http created' do
        expect(response.status).to eq(200)
      end
      it 'return token' do
        expect(json['token']).to be_present
      end
    end

    context 'with invalid email' do
      before do
        post '/api/v1/drivers/login', params: { driver:
                {
                  email: 'test@test.com',
                  password: '123456789'

                } }
      end
      it 'returns http unauthorized' do
        expect(response.status).to eq(401)
      end
      it 'returns error message' do
        expect(json['message']).to match('invalid email/password')
      end
    end
    context 'with invalid password' do
      before do
        post '/api/v1/drivers/login', params: { driver:
                {
                  email: email,
                  password: 'test password'

                } }
      end
      it 'returns http unauthorized' do
        expect(response.status).to eq(401)
      end
      it 'returns error message' do
        expect(json['message']).to match('invalid email/password')
      end
    end
  end
end
