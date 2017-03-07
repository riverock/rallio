module Rallio
  class SignOnToken
    include Virtus.model

    attribute :token, String
    attribute :expires_at, DateTime
    attribute :url, String
  end
end
