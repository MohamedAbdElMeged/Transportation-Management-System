require 'rails_helper'

RSpec.describe 'Api::V1::TrucksController', type: :request do
  let(:driver) { create :driver }
  let(:token) do
    payload = Auth::JwtHelper.generate_payload(driver)
    Auth::JwtHelper.encode(payload)
  end
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:truck, 10)
      get '/api/v1/trucks', headers: {
        "Authorization": "Bearer #{token}"
      }
    end
    it 'returns http success' do
      expect(json['data'].size).to eq(10)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /Assigned Trucks' do
    before do
      FactoryBot.create_list(:truck, 10)
      driver.trucks = Truck.all
      get '/api/v1/trucks/assigned_trucks', headers: {
        "Authorization": "Bearer #{token}"
      }
    end
    it 'returns http success' do
      expect(json['data'].size).to eq(10)
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /Assign Truck' do
    let!(:truck) { create :truck }
    context 'when truck is valid' do
      before do
        put "/api/v1/trucks/#{truck.id}/assign_truck", headers: {
          "Authorization": "Bearer #{token}"
        }
      end
      it 'returns http created' do
        expect(response.status).to eq(201)
        expect(driver.trucks.size).to eq(1)
        expect(json['data']['attributes']['assigned_at']).to be_present
      end
    end
    context "when truck isn\'t exist" do
      before do
        put '/api/v1/trucks/3253232532/assign_truck', headers: {
          "Authorization": "Bearer #{token}"
        }
      end
      it 'returns http 404 and truck not found error message' do
        expect(response.status).to eq(404)
        expect(json['error']).to match('Truck Not Found')
      end
    end
  end
end
