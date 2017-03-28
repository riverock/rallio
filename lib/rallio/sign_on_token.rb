module Rallio
  # Represents a sign on token object as it comes from Rallio.
  #
  # @!attribute [rw] token
  #   @return [String] token for SSO url
  # @!attribute [rw] expires_at
  #   @return [DateTime] DateTime token and url will become invalid.
  # @!attribute [rw] url
  #   @return [String] url to redirect user to for SSO with token embedded
  class SignOnToken < Base
    attribute :token, String
    attribute :expires_at, DateTime
    attribute :url, String

    # Creates new sign on token for user_id.
    #
    # @param user_id [Integer]
    # @return [Rallio::SignOnToken]
    def self.create(user_id:, params: {})
      response = self.post("/users/#{user_id}/sign_on_tokens", headers: app_credentials, params: params)
      new response.parsed_response['sign_on_token']
    end
  end
end
