require 'json_client'

module Authenticator
  module Client
    class AuthenticateResponse < JsonClient::BaseResponses::Response
      def initialize(body, code)
        super
      end

      def auth_success?
        json['authenticated'] == true
      end
    end
  end
end
