module Rallio
  # Represents an account object as it comes from Rallio.
  #
  # @!attribute [rw] id
  # @!attribute [rw] name
  # @!attribute [rw] short_name
  # @!attribute [rw] url
  # @!attribute [rw] city
  # @!attribute [rw] country_code
  # @!attribute [rw] time_zone
  class Account < Base
    attribute :id, Integer
    attribute :name, String
    attribute :short_name, String
    attribute :url, String
    attribute :city, String
    attribute :country_code, String
    attribute :time_zone, String

    # Retreives accounts.
    #
    # @param franchisor_id [Integer] franchisor_id to get accounts for
    # @return [Array<Rallio::Account>]
    def self.for(franchisor_id:)
      response = self.get("/franchisors/#{franchisor_id}/accounts", headers: app_credentials)
      response.parsed_response['accounts'].map { |a| new a }
    end

    # Creates an account.
    #
    # @param franchisor_id [Integer] franchisor_id to create account under
    # @param payload [Hash]
    # @option payload [Hash] :account data to create account with
    # @return [Hash] hash of account created
    def self.create(franchisor_id:, payload:)
      self.post("/franchisors/#{franchisor_id}/accounts", headers: app_credentials, body: payload).parsed_response
    end

    # Retreives reviews for the account.
    #
    # @param access_token [String] user access token for API access to account
    # @return [Array<Rallio::Review>]
    def reviews(access_token:)
      Review.all(type: type, id: id, access_token: access_token)
    end

    private

    def type
      :accounts
    end
  end
end
