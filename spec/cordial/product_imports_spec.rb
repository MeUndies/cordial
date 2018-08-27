require 'spec_helper'

RSpec.describe Cordial::ProductImports do
  let(:transport) { 'https' }
  let(:email) { 'test@example.com' }
  let(:url) { 'https://example.com/product-import.csv' }
  let(:job_id) { '12as34asfg56hj89kl' }

  describe '#import', :vcr do
    subject do
      described_class.import(transport: transport,
                             url: url,
                             email: email)
    end

    it 'has the correct payload' do
      payload = '{"source":{"transport":"https","url":"https://example.com/product-import.csv"},"hasHeader":true,"confirmEmail":"test@example.com"}'

      expect(subject.request.raw_body).to eq payload
    end

    it 'returns a job id' do
      response = subject

      expect(response['jobId']).to eq job_id
    end
  end
end
