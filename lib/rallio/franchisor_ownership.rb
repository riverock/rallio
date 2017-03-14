module Rallio
  # Represents a franchisor ownership as it comes from Rallio.
  #
  # @!attribute [rw] user_id
  #   @return [Integer] unique id for user
  # @!attribute [rw] franchisor_id
  #   @return [Integer] unique id for franchisor
  # @!attribute [rw] franchisor_name
  #   @return [String] franchisor name
  class FranchisorOwnership < OwnershipsBase
    attribute :user_id, Integer
    attribute :franchisor_id, Integer
    attribute :franchisor_name, String

    # Url segment used by base class to build correct endpoint.
    #
    # @return [String]
    def self.url_segment
      'franchisor_ownerships'
    end

    # Key used to extract response object from API response hash.
    #
    # @return [String]
    def self.response_key
      'franchisor_ownership'
    end
  end
end
