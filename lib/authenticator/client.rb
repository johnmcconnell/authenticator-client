require "authenticator/client/version"

base_dir = File.join(File.dirname(__FILE__), 'client')

Dir["#{base_dir + File::SEPARATOR}*.rb"].each do |file|
  require file
end

module Authenticator
  module Client
    @@configs = {}
    def self.register_config(key, config)
      @@configs[key] = config
    end

    def self.new(key)
      Base.new(@@configs[key])
    end
  end
end
