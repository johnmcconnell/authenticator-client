require 'rest_client'
require 'json_client'
require_relative 'authenticate_response'

module Authenticator
  module Client
    class Base < JsonClient::Base
      serializers do |s|
        s.on :create, :update, :destroy,
          use: JsonClient::ModelSerializer.new(model_name: 'account')
        s.on :index, :show, use: JsonClient::EmptySerializer.new
      end

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

      def request_authentication(params)
        uri = authenticate_path
        response = RestClient.post(
          uri,
          auth_params.merge(account: params).to_json,
          content_type: :json,
          accept: :json
        )
        AuthenticateResponse.new(response)
      end

      def authenticate_path
        "#{pather.host}/api/v1/authentications/authenticate"
      end
    end
  end
end
