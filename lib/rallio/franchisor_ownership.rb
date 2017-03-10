module Rallio
  class FranchisorOwnership < Base
    attribute :user_id, Integer
    attribute :franchisor_id, Integer
    attribute :franchisor_name, String

    def self.for(access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get('/franchisor_ownerships', headers: headers)
      response.parsed_response['franchisor_ownerships'].map { |f| new(f) }
    end
  end
end
