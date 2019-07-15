require 'spec_helper'

RSpec.describe Cordial::Contactactivities do
  let(:email) { 'super-random-email-address@example.com' }

  describe '#find', :vcr do
    subject { described_class.find(email: email) }

    context 'when record exists' do
      it 'provides a list of activity' do
        expect(subject.count).to be > 1
      end
    end

    context 'when record does not exists' do
      let(:email) { 'an-email-that-does-not-exists@example.com' }

      it 'returns record not found response' do
        expect(subject['message']).to eq('record not found')
      end
    end
  end

  describe '#create', :vcr do
    subject { described_class.create(email: email, a: action) }

    let(:action) { 'cart' }

    context 'with the correct parameters' do
      it 'creates the activity in Cordial' do
        expect(subject['success']).to eq(true)
      end
    end

    context 'with the wrong parameters' do
      let(:action) { nil }

      it 'does not create the activity in Cordial' do
        expect(subject['error']).to eq(true)
      end
    end
  end
end
