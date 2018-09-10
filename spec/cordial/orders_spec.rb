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

  describe '#find', :vcr do
    subject { described_class.find(id: order_id) }

    context 'when the record exists' do
      it 'returns the requested order' do
        response = subject

        expect(response['_id']).to eq('5b69e5bcd6ab4e7b3118ed9a')
      end
    end

    context 'when the record does not exits' do
      let(:order_id) { '9999' }
      it 'returns record not found response' do
        response = subject

        expect(response['message']).to eq('record not found')
      end
    end
  end

  describe '#create', :vcr do
    subject { described_class.create(options) }

    let(:options) do

      {
        email: 'antman@avengers.com',
        orderID: order_id,
        purchaseDate: purchase_date,
        items: items
      }
    end

    context 'on initial creation' do
      let(:order_id) { '10000' }
      it 'creates the order in Cordial' do
        expect(subject['success']).to eq(true)
      end
    end

    context 'on subsequent attempts to create' do
      it 'complains that order has already been created' do
        expect(subject['messages']).to eq('ID must be unique')
      end
    end

  end
end
