module Rallio
  # Represents a user object as it comes from Rallio.
  #
  # @!attribute [rw] id
  #   @return [Integer] unique id for user
  # @!attribute [rw] email
  #   @return [String] user email
  # @!attribute [rw] first_name
  #   @return [String] user first name
  # @!attribute [rw] last_name
  #   @return [String] user last name
  class User < Base
    attribute :id, Integer
    attribute :email, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :accounts, Array[Account]
    attribute :franchisors, Array[Franchisor]

    attr_writer :access_token

    # Lists accessible users on Rallio's platform for application.
    #
    # @return [Array<Rallio::User>] array of users accessible to application
    def self.accessible_users
      response = self.get('/accessible_users', headers: app_credentials)
      response.parsed_response['users'].map { |u| new u }
    end

    # Create a user on the Rallio platform.
    #
    # @param user [Hash] user info used to create new user
    # @option user [String] :email unique email address
    # @option user [String] :first_name
    # @option user [String] :last_name
    # @return [Rallio::User] user object that was just created
    def self.create(user:)
      response = self.post('/users', headers: app_credentials, body: { user: user })
      new response.parsed_response['user']
    end

    # Creates new single signon for user to be redirected to.
    # @see Rallio::SignOnToken
    #
    # @param params [Hash] optional uri params sent with request
    # @option params [String] :connect_account_id account id to display social
    #   connections for
    # @return [Rallio::SignOnToken]
    def sign_on_token(params: {})
      SignOnToken.create(user_id: id, params: params)
    end

    # Creates or returns the API access token for user.
    # @see Rallio::AccessToken
    #
    # NOTE: These tokens do not expire so it is suggested (recommended) that the
    # token be cached and reused whenever possible.
    #
    # @return [Rallio::AccessToken]
    def access_token
      @access_token ||= AccessToken.create(user_id: id)
    end

    # Retreives account ownerships for user.
    # @see Rallio::AccountOwnership
    #
    # @return [Array<Rallio::AccountOwnership>] array of user's account ownerships
    def account_ownerships
      AccountOwnership.for(access_token: access_token.access_token)
    end

    # Retreives franchisor ownerships for user.
    # @see Rallio::FranchisorOwnership
    #
    # @return [Array<Rallio::FranchisorOwnership>] array of user's franchisor ownerships
    def franchisor_ownerships
      FranchisorOwnership.for(access_token: access_token.access_token)
    end

    # Retreives current data for user.
    #
    # @return [Rallio::User]
    def dashboard
      response = self.class.get('/dashboard', headers: user_credentials)
      self.attributes = response.parsed_response
      self
    end

    private

    def user_credentials
      {
        'Authorization' => "Bearer #{access_token.access_token}"
      }
    end
  end
end
