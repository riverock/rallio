module Rallio
  class Franchisor < Account
    def self.all
      response = self.get('/franchisors', headers: app_credentials)
      response.parsed_response['franchisors'].map { |f| new(f) }
    end

    def accounts
      response = self.class.get("/franchisors/#{id}/accounts", headers: app_credentials)
      response.parsed_response['accounts'].map { |a| Rallio::Account.new(a) }
    end

    private

    def type
      :franchisors
    end
  end
end
