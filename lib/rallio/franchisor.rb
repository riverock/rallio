module Rallio
  class Franchisor < Account
    def self.all
      response = self.get('/franchisors', headers: app_credentials)
      response.parsed_response['franchisors'].map { |f| new(f) }
    end

    def accounts
      Rallio::Account.for(franchisor_id: id)
    end

    private

    def type
      :franchisors
    end
  end
end
