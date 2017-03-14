module Rallio
  # Represents an account ownership object as it comes from Rallio.
  #
  # @!attribute [rw] user_id
  # @!attribute [rw] account_id
  # @!attribute [rw] account_name
  # @!attribute [rw] account_franchisor_id
  # @!attribute [rw] account_franchisor_name
  class AccountOwnership < OwnershipsBase
    attribute :user_id, Integer
    attribute :account_id, Integer
    attribute :account_name, String
    attribute :account_franchisor_id, Integer
    attribute :account_franchisor_name, String

    # (see Rallio::FranchisorOwnership#self.url_segment)
    def self.url_segment
      'account_ownerships'
    end

    # (see Rallio::FranchisorOwnership#self.response_key)
    def self.response_key
      'account_ownership'
    end
  end
end
