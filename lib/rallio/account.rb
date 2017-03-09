module Rallio
  class Account < Base
    attribute :id, Integer
    attribute :name, String

    def reviews(access_token: access_token)
      Review.all(type: type, id: id, access_token: access_token)
    end

    private

    def type
      :accounts
    end
  end
end
