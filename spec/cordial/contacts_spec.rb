require "spec_helper"

RSpec.describe Cordial::Contacts do
  let(:email) { 'cordial@example.com' }

  describe '#find' do
    subject { described_class.find(email: email) }

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/contacts/cordial@example.com'
    end
  end

  describe '#create' do
     subject { described_class.create(email: email, attribute_list: attribute_list) }

     let(:attribute_list) do
       { first_name: 'Cordial' }
     end

     it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/contacts'
     end

     it 'has the correct payload' do
       expect(subject.request.raw_body).to eq 'channels[email][address]=cordial%40example.com&first_name=Cordial'
     end
  end
end

