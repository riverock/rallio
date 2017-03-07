module ResponseFixtures
  def accessible_users
    {
      "users": [
        {
          "id": 100,
          "email": "bob@yourcompany.com",
          "first_name": "Bob",
          "last_name": "Anderson",
          "accounts": [
            {
              "id": 200,
              "name": "Rally-O Tires Los Angeles"
            }
          ],
          "franchisors": [
            {
              "id": 300,
              "name": "Rally-O Tires"
            }
          ]
        }
      ]
    }
  end

  def sign_on_token
    {
      "sign_on_token": {
        "token": "15ad86b2ede6",
        "expires_at": "2015-04-16T23:56:30.321Z",
        "url": "https://app.rallio.com/api/internal/sign_on_tokens/15ad86b2ede6"
      }
    }
  end

  def access_token
    {
      "access_token": "4a25dd89e50bd0a0db1eeae65864fe6b",
      "user_id": 100,
      "expires_at": nil,
      "scopes": "user_info basic_access"
    }
  end
end
