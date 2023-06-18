require 'rails_helper'

describe Trucks::SetParams do
  describe '.call' do
    subject(:context) { described_class.call }
    it 'should set next_page parameter' do
      expect(context.params[:page]).to eq(1)
    end
  end
end
