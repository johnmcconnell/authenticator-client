module Authenticator
  module Client
    class Account
      attr_accessor :id, :username, :password, :created_at, :updated_at
      def initialize(username, password)
        @username = username
        @password = password
      end

      def to_params
        {
          account: {
            username: username,
            password: password
          }
        }
      end
      alias_method :to_h, :to_params
    end
  end
end
