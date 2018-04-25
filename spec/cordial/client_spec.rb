require 'spec_helper'

RSpec.describe Cordial::Client do

  let(:dummy_class) { DummyClass }

  class DummyClass
    include HTTParty
    extend Cordial::Client
  end

  describe '#client' do
    subject { dummy_class.client }

    it 'adds basic authentication headers' do
      expect(subject.default_options).to eq(
        basic_auth: {
          username: 'cordial-api-key',
          password: ''
        }
      )
    end
  end
end
