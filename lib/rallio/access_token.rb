module Rallio
  class AccessToken
    include Virtus.model

    attribute :access_token, String
    attribute :user_id, Integer
    attribute :expires_at, DateTime
    attribute :scopes, String
  end
end
