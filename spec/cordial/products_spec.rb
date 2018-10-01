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

  describe '#index', :vcr do
    subject { described_class.index }
    it 'provides a list of products' do
      response = subject
      expect(response.count).to eq(2)
    end
  end

  describe '#find', :vcr do
    subject { described_class.find(id: product_id) }

    context 'when the record exists' do
      it 'returns the requested product' do
        response = subject
        expect(response['productID']).to eq('1')
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 999 }
      it 'returns record not found response' do
        response = subject
        expect(response['message']).to eq('record not found')
      end
    end
  end

  describe '#create', :vcr do
    subject do
      described_class.create(id: product_id,
                             name: product_name,
                             options: {
                               price: price,
                               variants: variants,
                               inStock: true,
                               properties: {
                                 test_metadata_1: 'test metadata',
                                 test_metadata_2: 'test metadata'
                               }
                             })
    end

    it 'has the correct payload' do
      payload = '{"productID":1,"productName":"Test product","price":100,"variants":[{"sku":"skirt0912","attr":{"color":"blue","size":"8"}},{"sku":"skirt0913","attr":{"color":"red","size":"6"}}],"inStock":true,"properties":{"test_metadata_1":"test metadata","test_metadata_2":"test metadata"}}'

      expect(subject.request.raw_body).to eq payload
    end

    it 'returns a record created/updated' do
      response = subject
      expect(response['success']).to eq(true)
    end
  end
end
