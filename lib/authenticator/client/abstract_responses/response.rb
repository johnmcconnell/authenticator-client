module Authenticator
  module Client
    module AbstractResponses
      class Response
        attr_reader :body, :code

        def initialize(body, code)
          @body = body
          @code = code
        end

        def json
          parse_json
        end

        def success?
          code >= 200 && code < 300
        end

        protected

        def parse_json
          @parse_json ||= JSON.parse(body)
        end
      end
    end
  end
end
