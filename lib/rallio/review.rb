module Rallio
  class Review < Base
    attribute :id, Integer
    attribute :account_id, Integer
    attribute :account_name, String
    attribute :network, String
    attribute :posted_at, DateTime
    attribute :user_name, String
    attribute :user_image, String
    attribute :rating, Float
    attribute :message, String
    attribute :comments, Array[Hash]
    attribute :liked, Axiom::Types::Boolean
    attribute :url, String
    attribute :can_reply, Axiom::Types::Boolean
    attribute :location_name, String
    attribute :location_image_url, String
    attribute :review_reply, String
    attribute :review_reply_at, DateTime

    def self.all(type:, id:, access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get("/#{type}/#{id}/reviews", headers: headers)
      response.parsed_response['reviews'].map { |r| new(r) }
    end

    def reply(message:, access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      self.class.post("/reviews/#{id}/reply", headers: headers, body: { message: message })
    end
  end
end
