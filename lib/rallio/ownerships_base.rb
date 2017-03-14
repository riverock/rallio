module Rallio
  class OwnershipsBase < Base
    # Ownerships for access_token and url segment defined in class.
    #
    # @param access_token [String] user access token to get ownerships for
    def self.for(access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get("/#{url_segment}", headers: headers)
      response.parsed_response["#{url_segment}"].map { |a| new(a) }
    end

    # Create new ownership.
    #
    # @param user_id [Integer] user id to create ownership for
    # @param payload [Hash]
    # @option payload [Integer] :franchisor_id franchisor to link to user_id
    # @option payload [Integer] :account_id account to link to user_id
    # @return [Rallio::FranchisorOwnership, Rallio::AccountOwnership]
    #   object representing new ownership
    def self.create(user_id:, payload:)
      response = self.post("/users/#{user_id}/#{url_segment}", headers: app_credentials, body: payload)
      new response.parsed_response["#{response_key}"]
    end

    # Destroy ownership for user.
    #
    # @param user_id [Integer] user id to destory ownership for
    # @param object_id [Integer] can be either a franchisor_id or an account_id
    #   depending on what class this is called from
    def self.destroy(user_id:, object_id:)
      self.delete("/users/#{user_id}/#{url_segment}/#{object_id}", headers: app_credentials)
    end
  end
end
