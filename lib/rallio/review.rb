module Rallio
  # Represents a review object as it comes from Rallio.
  #
  # @!attribute [rw] id
  # @!attribute [rw] account_id
  # @!attribute [rw] account_name
  # @!attribute [rw] network
  # @!attribute [rw] posted_at
  # @!attribute [rw] user_name
  # @!attribute [rw] user_image
  # @!attribute [rw] rating
  # @!attribute [rw] message
  # @!attribute [rw] comments
  # @!attribute [rw] liked
  # @!attribute [rw] url
  # @!attribute [rw] can_reply
  # @!attribute [rw] location_name
  # @!attribute [rw] location_image_url
  # @!attribute [rw] review_reply
  # @!attribute [rw] review_reply_at
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

    # Retreives reviews.
    #
    # @param type [String] one of accounts or franchisors to get reviews for
    # @param id [Integer] account or franchisor id to get reviews for
    # @param access_token [String] user access token to use for authorization
    # @return [Array<Rallio::Review>]
    def self.all(type:, id:, access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get("/#{type}/#{id}/reviews", headers: headers)
      response.parsed_response['reviews'].map { |r| new(r) }
    end

    # Replies to review.
    #
    # @param message [String] text used for reply
    # @param access_token [String] user access token to use for authorization
    # @return [Hash] reply hash that was created
    def reply(message:, access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      self.class.post("/reviews/#{id}/reply", headers: headers, body: { message: message })
    end
  end
end
