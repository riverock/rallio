module Rallio
  # Represents an account object as it comes from Rallio.
  #
  # @!attribute [rw] id
  #   @return [Integer] unique id for account
  # @!attribute [rw] name
  #   @return [String] account name
  # @!attribute [rw] short_name
  #   @return [String] account short name
  # @!attribute [rw] url
  #   @return [String] account url
  # @!attribute [rw] city
  #   @return [String] account city
  # @!attribute [rw] country_code
  #   @return [String] account country code
  # @!attribute [rw] time_zone
  #   @return [String] account time zone
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
    # @param account [Hash]
    # @option account [String] :name
    # @option account [String] :short_name slug or other identifier
    # @option account [String] :url
    # @option account [String] :city
    # @option account [String] :country_code
    # @option account [String] :time_zone
    # @return [Rallio::Account] hash of account created
    def self.create(franchisor_id:, account:)
      response = self.post("/franchisors/#{franchisor_id}/accounts", headers: app_credentials, body: { account: account })
      new response.parsed_response['account']
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
