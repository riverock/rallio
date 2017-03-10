module Rallio
  class User < Base
    attribute :id, Integer
    attribute :email, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :accounts, Array[Account]
    attribute :franchisors, Array[Franchisor]

    attr_writer :access_token

    def self.accessible_users
      response = self.get('/accessible_users', headers: app_credentials)
      response.parsed_response['users'].map { |u| User.new(u) }
    end

    def self.create(user:)
      response = self.post('/users', headers: app_credentials, body: { user: user })
      new response.parsed_response['user']
    end

    def sign_on_token
      SignOnToken.create(user_id: id)
    end

    def access_token
      @access_token ||= AccessToken.create(user_id: id)
    end

    def account_ownerships
      response = self.class.get('/account_ownerships', headers: user_credentials)
      response.parsed_response
    end

    def franchisor_ownerships
      response = self.class.get('/franchisor_ownerships', headers: user_credentials)
      response.parsed_response
    end

    # Initially this endpoint was in the API docs but it appears it may not be
    # implemented. This is here until that gets cleared up.
    #
    # def me
    #   response = self.class.get('/users/me', headers: user_credentials)
    #   self.attributes = response.parsed_response
    #   self
    # end

    private

    def user_credentials
      { 'Authorization' => "Bearer #{access_token.access_token}" }
    end
  end
end
