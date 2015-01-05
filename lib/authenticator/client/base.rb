require 'rest_client'
require_relative 'abstract_client'
require_relative 'abstract_responses/response'

module Authenticator
  module Client
    class Base < AbstractClient
      attr_reader :api_key, :api_password, :host

      def initialize(config)
        super(Pather.new(config[:host], 'api/v1', 'accounts'), config)
      end

      def authenticate(account)
        uri = authenticate_path
        response = RestClient.post(
          uri,
          auth_params.merge(account.to_params).to_json,
          content_type: :json,
          accept: :json
        )
        AbstractResponses::Response.new(
          response.body,
          response.code
        )
      end

      protected

      def authenticate_path
        "#{pather.host}/api/v1/authentications/authenticate"
      end
    end
  end
end
