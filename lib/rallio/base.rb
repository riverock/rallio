module Rallio
  class Base
    include HTTParty
    include Virtus.model

    base_uri 'https://app.rallio.com/api/v1'

    attr_accessor :access_token

    def initialize(access_token: nil, **args)
      self.access_token = access_token
      super(**args)
    end

    def self.app_credentials
      {
        'X-Application-ID' => Rallio.application_id,
        'X-Application-Secret' => Rallio.application_secret
      }
    end
  end
end
