require 'attr_init'
module Authenticator
  module Client
    class Account
      reader_struct :id, :password, :created_at, :updated_at

      def self.from_json(json)
        params = json.each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
        end
        new(params)
      end

      def to_params
        {
          account: {
            id: id,
            password: password
          }
        }
      end
      alias_method :to_h, :to_params
    end
  end
end
