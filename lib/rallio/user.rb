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

    def sign_on_tokens
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
