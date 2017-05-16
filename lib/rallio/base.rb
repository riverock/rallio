module Rallio
  class Base
    include HTTParty
    include Virtus.model

    attribute :error, String

    base_uri 'https://app.rallio.com/api/v1'

    # The credentials that can be used in the headers of any request requiring
    # app level credentials
    #
    # @return [Hash] credentials hash
    def self.app_credentials
      {
        'X-Application-ID' => Rallio.application_id,
        'X-Application-Secret' => Rallio.application_secret
      }
    end
  end
end
