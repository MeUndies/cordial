require 'spec_helper'

RSpec.describe Cordial::Contacts do
  let(:email) { 'cordial@example.com' }

  describe '#find', :vcr do
    subject { described_class.find(email: email) }

    context 'when the record exists' do
      it 'returns the requested contact' do
        response = subject
        expect(response['_id']).to eq('5b69e5bc737953ab86decbe5')
      end
    end

    context 'when the record does not exits' do
      let(:email) { 'super-random-email-address@example.com' }

      it 'returns record not found response' do
        response = subject
        expect(response['message']).to eq('record not found')
      end
    end
  end

  describe '#create', :vcr do
    subject { described_class.create(email: email, attribute_list: attribute_list) }

    let(:attribute_list) do
      { First_Name: 'Cordial' }
    end

    it 'has the correct payload' do
      payload = '{"channels":{"email":{"address":"cordial@example.com"}},"First_Name":"Cordial"}'
      expect(subject.request.raw_body).to eq payload
    end

    it 'returns a record created/updated' do
      response = subject
      expect(response['success']).to eq(true)
    end
  end

  describe '#unsubscribe', :vcr do
    context 'when email only is passed' do
      subject { described_class.unsubscribe(email: email) }

      it 'has a correctly formatted request url' do
        unsubscribe_url = 'https://api.cordial.io/v1/contacts/cordial@example.com'
        expect(subject.request.last_uri.to_s).to eq unsubscribe_url
      end

      it 'the payload contains email and unsubscribe status' do
        payload = '{"channels":{"email":{"address":"cordial@example.com","subscribeStatus":"unsubscribed"}}}'

        expect(subject.request.raw_body).to eq payload
      end

      it 'returns unsubscribed success true' do
        response = subject
        expect(response['success']).to eq(true)
      end
    end

    context 'when channel and mcID are passed' do
      subject { described_class.unsubscribe(email: email, channel: 'email', mc_id: mc_id) }
      let(:email) { 'juan.ruiz@magmalabs.io' }
      let(:mc_id) { '645:5b6a1f26e1b829b63c2a7946:ot:5aea409bbb3dc2f9bc27158f:1' }

      it 'has a correctly formatted request url' do
        unsubscribe_url = 'https://api.cordial.io/v1/contacts/juan.ruiz@magmalabs.io/unsubscribe/email'
        expect(subject.request.last_uri.to_s).to eq unsubscribe_url
      end

      it 'the payload contains email and unsubscribe status' do
        payload = '{"mcID":"645:5b6a1f26e1b829b63c2a7946:ot:5aea409bbb3dc2f9bc27158f:1"}'

        expect(subject.request.raw_body).to eq payload
      end

      it 'returns unsubscribed success true' do
        response = subject
        expect(response['success']).to eq(true)
      end
    end
  end

  describe '#create_cart', :vcr do
    subject { described_class.create_cart(email, options) }

    let(:cart_id) { '33451' }
    let(:email) { 'cordial@example.com' }
    let(:cartitems) do
      [
        {
          productID: '1',
          sku: '123',
          name: 'Test Product 1',
          category: 'Test Category',
          attr: {
            color: 'blue',
            size: 'L'
          }
        }
      ]
    end

    let(:options) do
      {
        customerID: email,
        cartID: cart_id,
        cartitems: cartitems
      }
    end

    let(:cart_id) { '10000' }

    it 'creates the cart in Cordial' do
      expect(subject['success']).to eq(true)
    end
  end
end
