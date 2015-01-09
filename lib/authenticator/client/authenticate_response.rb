require 'json_client'

module Authenticator
  module Client
    class AuthenticateResponse < JsonClient::BaseResponses::Response
      def initialize(body, code)
        super
      end

      def account
        Account.from_json(json)
      end

      def authenticated?
        json['authenticated'] == true
      end

      def auth_success?
        authenticated?
      end
    end
  end
end
