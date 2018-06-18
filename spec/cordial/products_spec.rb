require 'spec_helper'

RSpec.describe Cordial::Products do
  let(:product_id) { 1 }

  describe '#find' do
    subject { described_class.find(id: product_id) }

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/products/1'
    end
  end
end
