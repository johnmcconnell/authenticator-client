module Authenticator
  module Client
    module AbstractResponses
      class Response
        attr_reader :body, :code

        def initialize(body, code)
          @body = body
          @code = code
        end

        def result
          parse_response
        end

        protected

        def parse_response
          @parse_reponse ||= JSON.parse(body)
        end
      end
    end
  end
end
