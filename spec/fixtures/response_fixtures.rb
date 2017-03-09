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

  def user_response
    accessible_users[:users].first
  end

  def reviews_response
    {
      "reviews": [
        {
          "id": 227704,
          "account_id": 9397,
          "account_name": "Rally-O Tires New York",
          "network": "facebook",
          "posted_at": "2017-02-21T23:12:33.000Z",
          "user_name": "Andy Bobson",
          "user_image": "https://graph.facebook.com/100009872044695/picture",
          "rating": 5,
          "message": "This is my favourite place to buy tires!",
          "comments": [
            {
              "user_name": "Rally-O Tires New York",
              "user_image": "https://graph.facebook.com/113397275345614/picture",
              "message": "Thanks for the 5 star review!",
              "created_at": "2017-02-22T00:49:53.000+00:00",
            }
          ],
          "liked": true,
          "url": "https://www.facebook.com/123123123",
          "can_reply": true,
          "location_name": "Visiting Angels Newburyport MA",
          "location_image_url": "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/16266055_1428821143803214_8378119243787669723_n.jpg?oh=3268e6e30474a0aa488cfd896a6d6c06&oe=59357742",
          "review_reply": nil,
          "review_reply_at": nil
        }
      ]
    }
  end
end
