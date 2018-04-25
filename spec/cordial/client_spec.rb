require 'spec_helper'

RSpec.describe Cordial::Client do

  let(:dummy_class) { DummyClass }

  class DummyClass
    include HTTParty
    extend Cordial::Client
  end

  describe '#client' do
    subject { dummy_class.client }

    it 'sets up the client' do
      expect(subject.default_options).to eq(
        base_uri: 'https://api.cordial.io/v1',
        basic_auth: {
          username: 'cordial-api-key',
          password: ''
        }
      )
    end
  end
end
