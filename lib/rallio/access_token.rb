module Rallio
  # Represents an access token object as it comes from Rallio.
  #
  # @!attribute [rw] access_token
  #   Access token string
  # @!attribute [rw] user_id
  # @!attribute [rw] expires_at
  #   @return [DateTime, nil] expiration DateTime or nil if access token never expires
  # @!attribute [rw] scopes
  #   List of oauth scopes for the access token
  class AccessToken < Base
    attribute :access_token, String
    attribute :user_id, Integer
    attribute :expires_at, DateTime
    attribute :scopes, String

    # Creates new access token for user_id.
    #
    # NOTE: These token do not expire so it is suggested (recommended) that the
    #       token be cached and reused whenever possible.
    #
    # @param user_id [Integer]
    # @return [Rallio::AccessToken]
    def self.create(user_id:)
      response = self.post("/users/#{user_id}/access_tokens", headers: app_credentials)
      new response.parsed_response
    end

    # Destroys access_token
    #
    # @return [true, nil] true if successful or nil
    def destroy
      headers = { 'Authorization' => "Bearer #{access_token}" }
      self.class.delete('/access_token', headers: headers)
      true
    end
  end
end
