
module Authenticator
  module Client
    class Pather
      attr_reader :host, :ext, :name

      def initialize(host, ext, name)
        @host = host
        @ext = ext
        @name = name
      end

      def path(id = nil)
        if id.nil?
          "#{host}/#{ext}/#{name}"
        else
          "#{host}/#{ext}/#{name}/#{id}"
        end
      end
    end
  end
end
