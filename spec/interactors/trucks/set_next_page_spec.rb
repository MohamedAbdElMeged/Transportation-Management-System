require 'rails_helper'

describe Trucks::SetNextPage do
  describe '.call' do
    subject(:context) { described_class }

    context 'when response_body_count >= 25 ' do
      let(:params) { { response_body_count: 25, response_headers: { 'current-page' => 1 } } }
      let(:context_response) { subject.call(params) }
      it 'should save next_page in redis with value = 2' do
        context_response
        expect(context_response.success?).to eq(true)
        expect(REDIS.get('next_page').to_i).to eq(2)
      end
    end
    context 'when response_body_count < 25 ' do
      before do
        REDIS.set('next_page', 1)
      end

      let(:params) { { response_body_count: 22, response_headers: { 'current-page' => 2, 'total-pages' => '2' } } }
      let(:context_response) { subject.call(params) }
      it "shouldn\'t change next_page" do
        context_response
        expect(context_response.success?).to eq(true)
        expect(REDIS.get('next_page').to_i).to eq(1)
      end
    end
  end
end
