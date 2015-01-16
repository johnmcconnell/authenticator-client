require 'json_client'

module Authenticator
  module Client
    class AuthenticateResponse < JsonClient::BaseResponses::Response
      def initialize(response)
        super
      end

      def account
        Account.from_json(json)
      end

      def authenticated?
        json['authenticated'] == true
      end
    end
  end
end
