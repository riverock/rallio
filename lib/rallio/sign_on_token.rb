module Rallio
  class SignOnToken < Base
    attribute :token, String
    attribute :expires_at, DateTime
    attribute :url, String

    def self.create(user_id:)
      response = self.post("/users/#{user_id}/sign_on_tokens", headers: app_credentials)
      new response.parsed_response['sign_on_token']
    end
  end
end
