module Rallio
  class Base
    include HTTParty
    include Virtus.model

    base_uri 'https://app.rallio.com/api/v1'

    private

    def self.app_credentials
      {
        'X-Application-ID' => Rallio.application_id,
        'X-Application-Secret' => Rallio.application_secret
      }
    end

    def app_credentials
      self.class.app_credentials
    end
  end
end
