module Rallio
  # Represents a sign on token object as it comes from Rallio.
  #
  # @!attribute [rw] token
  # @!attribute [rw] expires_at
  #   DateTime token and url will become invalid.
  # @!attribute [rw] url
  #   Url to redirect user to for SSO with token embedded
  class SignOnToken < Base
    attribute :token, String
    attribute :expires_at, DateTime
    attribute :url, String

    # Creates new sign on token for user_id.
    #
    # @param user_id [Integer]
    # @return [Rallio::SignOnToken]
    def self.create(user_id:)
      response = self.post("/users/#{user_id}/sign_on_tokens", headers: app_credentials)
      new response.parsed_response['sign_on_token']
    end
  end
end
