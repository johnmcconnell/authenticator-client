require 'spec_helper'
require 'rspec/collection_matchers'
require 'authenticator/client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe Authenticator::Client::Base do
  let(:config) do
    {
      api_key: '124ecd49-07fd-4553-a5cd-0178b7fa8b3f',
      api_password: 'IIoclO7kmQqJ1wixWrAuOA',
      host: 'http://account-authenticator.herokuapp.com'
    }
  end

  let(:account) do
    Authenticator::Client::Account.new('new_username', 'new_password')
  end

  subject do
    Authenticator::Client.register_config(:test, config)
    Authenticator::Client.new(:test)
  end

  describe '#all' do
    it 'fetches all the accounts' do
      VCR.use_cassette('all_success') do
        response = JSON.parse(subject.all)

        expect(response['accounts']).not_to be nil
      end
    end
  end

  describe '#create' do
    it 'creates an account' do
      VCR.use_cassette('create_success') do
        response = JSON.parse(
          subject.create(account)
        )

        expect(response['username']).to eq 'new_username'
        expect(response['id']).not_to be nil
        expect(response['created_at']).not_to be nil
        expect(response['updated_at']).not_to be nil
      end
    end
  end

  describe '#show' do
    it 'fetches all the accounts' do
      VCR.use_cassette('index_success') do
        response = JSON.parse(subject.all)

        expect(response['accounts']).not_to be nil
      end
    end
  end
end
