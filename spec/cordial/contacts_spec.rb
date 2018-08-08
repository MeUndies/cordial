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

  # TODO, revisit this test when the cordial People respond why we have
  # an error 500 when the contact is being unsubscribed in the platform.
  describe '#unsubscribe', :vcr do
    subject { described_class.unsubscribe(email: email) }

    it 'has a correctly formatted request url' do
      unsubscribe_url = 'https://api.cordial.io/v1/contacts/cordial@example.com/unsubscribe/email'
      expect(subject.request.last_uri.to_s).to eq unsubscribe_url
    end
  end
end
