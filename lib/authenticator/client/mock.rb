require 'json'
require 'attr_init'
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
        response_object = MockResponse.new(
          body: params.merge({ authenticated: true }).to_json,
          code: 200
        )
        AuthenticateResponse.new(response_object)
      end
    end

    class MockResponse
      reader_struct :body, :code
    end
  end
end
