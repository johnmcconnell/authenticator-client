require_relative 'response'

module Authenticator
  module Client
    module AbstractResponses
      class Update < Response
        def initialize(body, code)
          super
        end
      end
    end
  end
end
