module Rallio
  class Franchisor < Account
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

    private

    def type
      :franchisors
    end
  end
end
