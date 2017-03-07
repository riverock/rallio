module Rallio
  class AccessToken < Base
    attribute :access_token, String
    attribute :user_id, Integer
    attribute :expires_at, DateTime
    attribute :scopes, String

    def self.create(user_id:)
      response = self.post("/users/#{user_id}/access_token", headers: app_credentials)
      new response.parsed_response
    end
  end
end
