require "authenticator/client/version"

base_dir = File.join(File.dirname(__FILE__), 'client')

Dir["#{base_dir + File::SEPARATOR}*.rb"].each do |file|
  require file
end

module Authenticator
  module Client
    @@configs = {}
    @@stubbed_account = nil

    def self.register_config(key, config)
      @@configs[key] = config
    end

    def self.new(key)
      if @@stubbed_account
        Mock.new(@@stubbed_account)
      else
        Base.new(@@configs[key], @@stubbed_account)
      end
    end


    def self.configs
      @@configs
    end

    def self.reset!
      @@stubbed_account = nil
    end

    def self.authenticate_with!(account)
      @@stubbed_account = account
    end
  end
end
