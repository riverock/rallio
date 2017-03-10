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

    private

    def type
      :accounts
    end
  end
end
