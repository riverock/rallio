module Rallio
  class FranchisorOwnership < OwnershipsBase
    attribute :user_id, Integer
    attribute :franchisor_id, Integer
    attribute :franchisor_name, String

    def self.url_segment
      'franchisor_ownerships'
    end

    def self.response_key
      'franchisor_ownership'
    end
  end
end
