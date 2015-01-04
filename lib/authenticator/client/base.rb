require 'rest_client'

module Authenticator
  module Client
    class Base
      attr_reader :api_key, :api_password, :host

      def initialize(config)
        @api_key = config[:api_key]
        @api_password = config[:api_password]
        @host = config[:host]
        validate_variables
      end

      def all
        uri = account_path
        RestClient.get uri, params: auth_params
      end

      def show(id)
        uri = account_path(id)
        RestClient.get uri, params: auth_params
      end

      def create(account)
        uri = account_path
        RestClient.post(
          uri,
          auth_params.merge(account.to_params).to_json,
          content_type: :json,
          accept: :json
        )
      end

      def update(id, account)
        uri = account_path(id)
        RestClient.post(
          uri,
          auth_params.merge(account.to_params).to_json,
          content_type: :json,
          accept: :json
        )
      end

      def destroy(id)
        uri = account_path(id)
        RestClient.delete(
          uri,
          auth_params.to_json,
          content_type: :json,
          accept: :json
        )
      end

      protected

      def account_path(id = nil)
        if id.nil?
          "#{host}/api/v1/accounts"
        else
          "#{host}/api/v1/accounts/#{id}"
        end
      end

      def auth_params
        {
          api_key: api_key,
          api_password: api_password
        }
      end

      private

      def validate_variables
        fail 'host must be set' if host.nil?
        fail 'api_key must be set' if api_key.nil?
        fail 'api_password must be set' if api_key.nil?
      end
    end
  end
end
