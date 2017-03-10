module Rallio
  class AccountOwnership < Base
    attribute :user_id, Integer
    attribute :account_id, Integer
    attribute :account_name, String
    attribute :account_franchisor_id, Integer
    attribute :account_franchisor_name, String

    def self.for(access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get('/account_ownerships', headers: headers)
      response.parsed_response['account_ownerships'].map { |a| new(a) }
    end
  end
end
