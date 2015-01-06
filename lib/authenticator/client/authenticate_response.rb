require_relative 'abstract_responses/response'

module Authenticator
  module Client
    class AuthenticateResponse < AbstractResponses::Response
      def initialize(body, code)
        super
      end

      def auth_success?
        json['authenticated'] == true
      end
    end
  end
end
