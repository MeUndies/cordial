require 'spec_helper'

RSpec.describe Cordial::AutomationTemplates do
  let(:key) { 'promo2018' }
  let(:name) { 'Promo 2018' }
  let(:channel) { 'email' }
  let(:classification) { 'promotional' }
  let(:base_aggregation) { 'hourly' }
  let(:email) { 'info@example.com' }
  let(:order_number) { 'R123456789' }
  let(:headers) do
    {
      subject_email: 'One Day Only Sale',
      from_email: email,
      reply_email: email,
      from_description: 'Promotions Team'
    }
  end
  let(:content) do
    {
      text: '<div>Hello World</div>'
    }
  end

  describe '#create', :vcr do
    subject do
      described_class.create(
        key: key,
        name: name,
        channel: channel,
        classification: classification,
        base_aggregation: base_aggregation,
        headers: {
          subject_email: headers[:subject_email],
          from_email: headers[:from_email],
          reply_email: headers[:reply_email],
          from_description: headers[:from_description]
        },
        content: {
          text: '<div>Hello World</div>'
        }
      )
    end

    it 'has the correct payload' do
      payload = '{"key":"promo2018","name":"Promo 2018","channel":"email","classification":"promotional","baseAggregation":"hourly","message":{"headers":{"subject":"One Day Only Sale","fromEmail":"info@example.com","replyEmail":"info@example.com","fromDesc":"Promotions Team"},"content":{"text/html":"<div>Hello World</div>"}}}'
      expect(subject.request.raw_body).to eq payload
    end

    context 'when it is a new template' do
      let(:key) { 'new_promo' }
      it 'returns a record created' do
        response = subject
        expect(response['success']).to eq(true)
        expect(response.code).to eq(201)
      end
    end

    context 'when it is an existing template' do
      it 'returns a message error' do
        response = subject
        expect(response['error']).to eq(true)
        expect(response.code).to eq(422)
      end
    end
  end

  describe '#send', :vcr do
    subject do
      described_class.send(
        key: key,
        email: email,
        order: {
          number: order_number
        }
      )
    end

    it 'has the correct payload' do
      payload = '{"to":{"contact":{"email":"info@example.com"},"extVars":{"order":{"number":"R123456789"}}}}'
      expect(subject.request.raw_body).to eq payload
    end

    context 'when an email is sent' do
      it 'returns a successful message' do
        response = subject
        expect(response['success']).to eq(true)
        expect(response.code).to eq(201)
      end
    end

    context 'when the key is empty' do
      let(:key) { '' }
      it 'returns a message error' do
        response = subject
        expect(response['error']).to eq("'/v1/automationtemplates//send' is not found.")
        expect(response.code).to eq(404)
      end
    end

    context 'when the key is not found' do
      let(:key) { 'promo' }
      it 'returns a message error' do
        response = subject
        expect(response['error']).to eq('an error has occurred')
        expect(response.code).to eq(500)
      end
    end
  end
end
