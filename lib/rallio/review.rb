module Rallio
  # Represents a review object as it comes from Rallio.
  #
  # @!attribute [rw] id
  #   @return [Integer] unique id for review
  # @!attribute [rw] account_id
  #   @return [Integer] unique id for account
  # @!attribute [rw] account_name
  #   @return [String] account name
  # @!attribute [rw] network
  #   @return [String] social network review was posted to
  # @!attribute [rw] posted_at
  #   @return [DateTime] DateTime review was made
  # @!attribute [rw] user_name
  #   @return [String] social network username of reviewer
  # @!attribute [rw] user_image
  #   @return [String] link to image of reviewer
  # @!attribute [rw] rating
  #   @return [Integer] overall review rating
  # @!attribute [rw] message
  #   @return [String] review text left by reviewer
  # @!attribute [rw] comments
  #   @return [Array<Hash>] for facebook this is an array of responses to review
  # @!attribute [rw] liked
  #   @return [true, false] true if review has been liked
  # @!attribute [rw] url
  #   @return [String] url to review
  # @!attribute [rw] can_reply
  #   @return [true, false] true if review can be replied to
  # @!attribute [rw] location_name
  #   @return [String] location review is for
  # @!attribute [rw] location_image_url
  #   @return [String] url for image of location
  # @!attribute [rw] review_reply
  #   @return [String] reply for non-facebook reviews
  # @!attribute [rw] review_reply_at
  #   @return [DateTime] DateTime of reply for non-facebook reviews
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

    # Retreives reviews. All query_params are optional. If no query_params are
    # passed in all reviews accessible to user are returned.
    #
    # @param query_params [Hash] params to filter results
    # @option query_params [String] :page results page
    # @option query_params [String] :account_id filter results to one or more
    #   accounts, should be seperated by commas
    # @option query_params [String] :franchisor_id filter results to a single
    #   franchisor
    # @option query_params [String] :network filter results to one network,
    #   possible choices are facebook, google_places, yelp
    # @option query_params [String] :start_date iso8601 date to start on
    # @option query_params [String] :end_date iso8601 date to end on
    # @option query_params [String] :rating filter by rating
    # @param access_token [String] user access token to use for authorization
    # @return [Array<Rallio::Review>]
    def self.all(query_params: {}, access_token:)
      headers = { 'Authorization' => "Bearer #{access_token}" }
      response = self.get("/reviews", query: query_params, headers: headers)
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
