module Rallio
  # Represents an franchisor object as it comes from Rallio.
  #
  # @!attribute [rw] id
  #   @return [Integer] unique id for franchisor
  # @!attribute [rw] name
  #   @return [String] account name
  class Franchisor < Base
    attribute :id, Integer
    attribute :name, String

    # Retreives all franchisors for a given application.
    #
    # @return [Array<Rallio::Franchisor>]
    def self.all
      response = self.get('/franchisors', headers: app_credentials)
      response.parsed_response['franchisors'].map { |f| new(f) }
    end

    # Retreives all accounts for the Rallio::Franchisor
    # @see Rallio::Account
    #
    # @return [Array<Rallio::Account>]
    def accounts
      Rallio::Account.for(franchisor_id: id)
    end

    # Retreives reviews for the franchisor.
    #
    # @param access_token [String] user access token for API access to account
    # @return [Array<Rallio::Review>]
    def reviews(access_token:)
      Review.all(type: type, id: id, access_token: access_token)
    end

    private

    def type
      :franchisors
    end
  end
end
