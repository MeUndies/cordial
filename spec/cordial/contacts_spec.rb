require "spec_helper"

RSpec.describe Cordial::Contacts do
  describe '#find' do

    subject { described_class.find(email: email) }

    let(:email) { 'cordial@example.com' }

    it 'has a correctly formatted request url' do
      expect(subject.request.last_uri.to_s).to eq 'https://api.cordial.io/v1/contacts/cordial@example.com'
    end
  end
end

