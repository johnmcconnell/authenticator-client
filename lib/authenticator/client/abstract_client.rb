require 'rest_client'

module Authenticator
  module Client
    class AbstractClient
      attr_reader :api_key, :api_password, :pather

      def initialize(pather, config)
        @api_key = config[:api_key]
        @api_password = config[:api_password]
        @pather = pather
        validate_variables
      end

      def all
        uri = request_path
        RestClient.get uri, params: auth_params
      end

      def show(id)
        uri = request_path(id)
        RestClient.get uri, params: auth_params
      end

      def create(model)
        uri = request_path
        RestClient.post(
          uri,
          auth_params.merge(create_params(model)).to_json,
          content_type: :json,
          accept: :json
        )
      end

      def update(id, model)
        uri = request_path(id)
        RestClient.put(
          uri,
          auth_params.merge(update_params(model)).to_json,
          content_type: :json,
          accept: :json
        )
      end

      def destroy(id)
        uri = request_path(id)
        RestClient.delete(
          uri, params: auth_params
        )
      end

      protected

      def create_params(model)
        model.to_json
      end

      def update_params(model)
        model.to_json
      end

      def request_path(id = nil)
        pather.path(id)
      end

      def auth_params
        {
          api_key: api_key,
          api_password: api_password
        }
      end

      private

      def validate_variables
        fail 'api_key must be set' if api_key.nil?
        fail 'api_password must be set' if api_key.nil?
        fail 'pather must be set' if api_key.nil?
      end
    end
  end
end
