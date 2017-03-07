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

    def destroy
      headers = { 'Authentication' => "Bearer #{access_token}" }
      self.class.delete('/access_token', headers: headers)
      true
    end
  end
end
