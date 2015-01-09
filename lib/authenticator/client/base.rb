require 'rest_client'
require 'json_client'
require_relative 'authenticate_response'

module Authenticator
  module Client
    class Base < JsonClient::Base
      def initialize(config, account)
        super(
          JsonClient::Pather.new(config[:host], 'api/v1', 'accounts'),
          config
        )
      end

      def authenticate(account)
        request_authentication(account)
      end

      protected

      def request_authentication(account)
        uri = authenticate_path
        response = RestClient.post(
          uri,
          auth_params.merge(account.to_h).to_json,
          content_type: :json,
          accept: :json
        )
        AuthenticateResponse.new(response.body, response.code)
      end

      def authenticate_path
        "#{pather.host}/api/v1/authentications/authenticate"
      end
    end
  end
end
