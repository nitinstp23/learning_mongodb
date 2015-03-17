module Exceptions

  class BaseError < StandardError
    attr_accessor :message

    def initialize(attributes = {})
      attributes.each do |name, value|
        public_send("#{name}=", value)
      end
    end
  end

  class OAuthError < BaseError
    attr_accessor :provider
  end

end
