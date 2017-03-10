module Rallio
  class AccountOwnership < Base
    attribute :user_id, Integer
    attribute :account_id, Integer
    attribute :account_name, String
    attribute :account_franchisor_id, Integer
    attribute :account_franchisor_name, String
  end
end
