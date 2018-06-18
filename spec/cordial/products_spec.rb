require 'spec_helper'

RSpec.describe Cordial::Products do
  let(:product_id) { 1 }
  let(:product_name) { 'Test product' }
  let(:price) { 100 }
  let(:variants) do
    [
      {
        sku: 'skirt0912',
        attr: {
          color: 'blue',
          size: '8'
        }
      },
      {
        sku: 'skirt0913',
        attr: {
          color: 'red',
          size: '6'
        }
      }
    ]
  end

  describe '#find' do
    subject { described_class.find(id: product_id) }

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/products/1'
    end
  end

  describe '#create' do
    subject do
      described_class.create(id: product_id,
                             name: product_name,
                             price: price,
                             variants: variants)
    end

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/products'
    end

    it 'has the correct payload' do
      payload = '{"productID":1,"productName":"Test product","price":100,"variants":[{"sku":"skirt0912","attr":{"color":"blue","size":"8"}},{"sku":"skirt0913","attr":{"color":"red","size":"6"}}]}'

      expect(subject.request.raw_body).to eq payload
    end
  end
end
