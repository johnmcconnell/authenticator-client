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

  let(:new_account) do
    Authenticator::Client::Account.new('new_username_1', 'new_password_1')
  end

  let(:destroy_account) do
    Authenticator::Client::Account.new('new_username_2', 'new_password_2')
  end

  let(:updated_account) do
    Authenticator::Client::Account.new('updated_username', 'updated_password')
  end

  subject do
    Authenticator::Client.register_config(:test, config)
    Authenticator::Client.new(:test)
  end

  describe '#all' do
    it 'fetches all the accounts' do
      VCR.use_cassette('all_success') do
        response = subject.index.result

        expect(response['accounts']).not_to be nil
      end
    end
  end

  describe '#authenticate' do
    it 'creates an account' do
      VCR.use_cassette('authenticate_success') do
        response = subject.authenticate(account).result

        expect(response['authenticated']).to eq true
      end
    end
  end

  describe '#create' do
    it 'creates an account' do
      VCR.use_cassette('create_success') do
        response = subject.create(account).result

        expect(response['username']).to eq 'new_username'
        expect(response['id']).not_to be nil
        expect(response['created_at']).not_to be nil
        expect(response['updated_at']).not_to be nil
      end
    end
  end

  describe '#show' do
    it 'fetches the account' do
      VCR.use_cassette('show_success') do
        response = subject.show(6).result

        expect(response['username']).to eq 'new_username'
      end
    end
  end

  describe '#update' do
    it 'updates the account' do
      VCR.use_cassette('update_success') do
        id = subject.create(new_account).result['id']
        response = subject.update(id, updated_account).result

        expect(response['username']).to eq updated_account.username
        expect(response['id']).to eq id
      end
    end
  end

  describe '#destroy' do
    it 'destroys the account' do
      VCR.use_cassette('destroy_success') do
        id = subject.create(destroy_account).result['id']
        response = subject.destroy(id).result

        expect(response['id']).to eq id
      end
    end
  end
end
