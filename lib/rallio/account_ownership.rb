module Rallio
  class AccountOwnership < OwnershipsBase
    attribute :user_id, Integer
    attribute :account_id, Integer
    attribute :account_name, String
    attribute :account_franchisor_id, Integer
    attribute :account_franchisor_name, String

    def self.url_segment
      'account_ownerships'
    end

    def self.response_key
      'account_ownership'
    end
  end
end
