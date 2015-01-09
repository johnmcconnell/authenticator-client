require 'json'
require_relative 'authenticate_response'

module Authenticator
  module Client
    class Mock
      attr_reader :params
      def initialize(params)
        @params = params
      end

      def authenticate(_account)
        mock_response
      end

      protected

      def mock_response
        AuthenticateResponse.new(
          params.merge({ authenticated: true }).to_json,
          200
        )
      end
    end
  end
end
