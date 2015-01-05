require 'spec_helper'
require 'rspec/collection_matchers'
require 'authenticator/client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe Authenticator::Client do
  let(:config) do
    {
      api_key: '124ecd49-07fd-4553-a5cd-0178b7fa8b3f',
      api_password: 'IIoclO7kmQqJ1wixWrAuOA',
      host: 'http://account-authenticator.herokuapp.com'
    }
  end

  describe '::register' do
    it 'registers a configuration to be used when invoked with ::new' do
      described_class.register_config(:test, config)
      client = described_class.new(:test)
      expect(client.pather.host).to eq config[:host]
      expect(client.api_key).to eq config[:api_key]
      expect(client.api_password).to eq config[:api_password]
    end
  end
end
