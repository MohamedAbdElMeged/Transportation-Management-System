require 'rails_helper'

describe Trucks::SaveNewTrucks do
  describe '.call' do
    subject(:context) { described_class.call(params) }
    context 'when response body is nil' do
      let(:params) { { response_body: nil } }
      it 'should fail' do
        expect(context).to be_a_failure
        expect(context.message).to  be_present
        expect(context.message).to  match('No new trucks found')
      end
    end
    context 'when response body is not nil' do
      let(:params) do
        { response_body: [
          {
            "id": 1,
            "name": 'ONREC',
            "truck_type": 'trella',
            "created_at": '2023-06-14T13:44:14.346Z',
            "updated_at": '2023-06-14T13:44:14.346Z'
          },
          {
            "id": 2,
            "name": 'INGIL',
            "truck_type": 'trella',
            "created_at": '2023-06-14T13:44:14.356Z',
            "updated_at": '2023-06-14T13:44:14.356Z'
          },
        ] }
      end
      it 'should success' do
        expect(context.success?).to eq(true)
        expect(Truck.all.pluck(:name)).to eq(%w(ONREC INGIL))
      end
    end
  end
end
