module Authenticator
  module Client
    class Account
      attr_accessor :id, :username, :password, :created_at, :updated_at
      def initialize(params, password=nil)
        if password.nil?
          new_initialize(params)
        else
          old_initialize(params, password)
        end
      end

      def new_initialize(params)
        @id = params[:id]
        @username = params[:username]
        @password = params[:password]
        @created_at = params[:created_at]
        @updated_at = params[:updated_at]
      end

      def old_initialize(username, password)
        @username = username
        @password = password
      end

      def self.from_json(json)
        params = json.each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
        end
        new(params)
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
