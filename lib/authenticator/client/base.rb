require 'rest_client'
require 'json_client'
require_relative 'authenticate_response'

module Authenticator
  module Client
    class Base < JsonClient::Base
      def initialize(config)
        super(
          JsonClient::Pather.new(config[:host], 'api/v1', 'accounts'),
          config
        )
      end

      def authenticate(account)
        uri = authenticate_path
        response = RestClient.post(
          uri,
          auth_params.merge(account.to_h).to_json,
          content_type: :json,
          accept: :json
        )
        AuthenticateResponse.new(response.body, response.code)
      end

      protected

      def authenticate_path
        "#{pather.host}/api/v1/authentications/authenticate"
      end
    end
  end
end
