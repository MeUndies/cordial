require 'spec_helper'

RSpec.describe Cordial::Orders do
  let(:order_id) { '33451' }
  let(:email) { 'cordial@example.com' }
  let(:purchase_date) { '2018-07-02 13:19:00' }
  let(:items) do
    [
      {
        productID: '1',
        sku: '123',
        name: 'Test Product 1',
        attr: {
          color: 'blue',
          size: 'L'
        }
      }
    ]
  end

  describe '#find' do
    subject { described_class.find(id: order_id) }

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/orders/33451'
    end
  end

  describe '#create' do
    subject do
      described_class.create(id: order_id,
                             email: email,
                             purchase_date: purchase_date,
                             items: items)
    end

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/orders'
    end

    it 'has the correct payload' do
      payload = '{"orderID":"33451","email":"cordial@example.com","purchaseDate":"2018-07-02 13:19:00","items":[{"productID":"1","sku":"123","name":"Test Product 1","attr":{"color":"blue","size":"L"}}]}'

      expect(subject.request.raw_body).to eq payload
    end
  end
end
