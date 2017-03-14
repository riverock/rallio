module Rallio
  class Account < Base
    attribute :id, Integer
    attribute :name, String
    attribute :short_name, String
    attribute :url, String
    attribute :city, String
    attribute :country_code, String
    attribute :time_zone, String

    def reviews(access_token:)
      Review.all(type: type, id: id, access_token: access_token)
    end

    def self.for(franchisor_id:)
      response = self.get("/franchisors/#{franchisor_id}/accounts", headers: app_credentials)
      response.parsed_response['accounts'].map { |a| new a }
    end

    def self.create(franchisor_id:, payload:)
      self.post("/franchisors/#{franchisor_id}/accounts", headers: app_credentials, body: payload).parsed_response
    end

    private

    def type
      :accounts
    end
  end
end
