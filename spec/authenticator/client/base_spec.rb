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
      api_key: 'apptest',
      api_password: 'password',
      host: 'http://account-authenticator.herokuapp.com'
    }
  end

  let(:account_params) do
    { id: 0, password: 'new_password' }
  end

  let(:new_account_params) do

    { id: 1, password: 'new_password_1' }
  end

  let(:destroy_account_params) do

    { id: 2, password: 'new_password_2' }
  end

  let(:updated_account_params) do

    { id: 3, password: 'new_password' }
  end

  let(:account) do
    Authenticator::Client::Account.new(account_params)
  end

  let(:new_account) do
    Authenticator::Client::Account.new(new_account_params)
  end

  let(:destroy_account) do
    Authenticator::Client::Account.new(destroy_account_params)
  end

  let(:updated_account) do
    Authenticator::Client::Account.new(updated_account_params)
  end

  subject do
    Authenticator::Client.register_config(:test, config)
    Authenticator::Client.new(:test)
  end

  describe '#index' do
    it 'fetches all the accounts' do
      VCR.use_cassette('all_success') do
        response = subject.index.json

        expect(response['accounts']).not_to be nil
      end
    end
  end

  describe '#authenticate' do
    it 'creates an account' do
      VCR.use_cassette('authenticate_success') do
        response = subject.authenticate(id: 4, password: 'new_password')

        expect(response.json['authenticated']).to eq true
        expect(response.authenticated?).to eq true

        account = response.account

        expect(account.id).to be 4
        expect(account.created_at).not_to be nil
        expect(account.updated_at).not_to be nil
      end
    end
  end

  describe '#create' do
    it 'creates an account' do
      VCR.use_cassette('create_success') do
        response = subject.create(account).json

        expect(response['id']).not_to be nil
        expect(response['created_at']).not_to be nil
        expect(response['updated_at']).not_to be nil
      end
    end
  end

  describe '#show' do
    it 'fetches the account' do
      VCR.use_cassette('show_success') do
        response = subject.show(1)
        json = response.json

        expect(json['id']).to be 1
        expect(response['created_at']).not_to be nil
        expect(response['updated_at']).not_to be nil
      end
    end
  end

  describe '#update' do
    it 'updates the account' do
      VCR.use_cassette('update_success') do
        id = subject.create(new_account).json['id']
        response = subject.update(id, updated_account).json

        expect(response['id']).to eq id
      end
    end
  end

  describe '#destroy' do
    it 'destroys the account' do
      VCR.use_cassette('destroy_success') do
        id = subject.create(destroy_account).json['id']
        response = subject.destroy(id).json

        expect(response['id']).to eq id
      end
    end
  end
end
