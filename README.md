[![Code Climate](https://codeclimate.com/github/jdguzman/rallio/badges/gpa.svg)](https://codeclimate.com/github/jdguzman/rallio)
[![Build Status](https://travis-ci.org/jdguzman/rallio.svg?branch=master)](https://travis-ci.org/jdguzman/rallio)
[![Test Coverage](https://codeclimate.com/github/jdguzman/rallio/badges/coverage.svg)](https://codeclimate.com/github/jdguzman/rallio/coverage)
[![Issue Count](https://codeclimate.com/github/jdguzman/rallio/badges/issue_count.svg)](https://codeclimate.com/github/jdguzman/rallio)

# Rallio

This is a ruby implementation of the Rallio API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rallio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rallio

## Usage

The documentation here is specific to the gem and it's usage. Detailed
information on the Rallio API can be found at
https://mark.przepiora.ca/tmp/rallio-public-api-documentation.

### Configuration

In order to use the gem you will need to configure your `application_id` and
`application_secret` provided to you by Rallio. If you are using this within a
Rails context you should do this in an initializer. Otherwise you need to set
this up before you make any calls to the API.

```ruby
Rallio.application_id = '<your id>'               # => '<your_id>'
Rallio.application_secret = '<your secret>'       # => '<your secret>'
```

### User

#### .accessible_users

The user class can be used to access all available users for a given
application.

```ruby
Rallio::User.accessible_users
# =>
# [<Rallio::User:0x007fc325b36808 @id=100, @email="bob@yourcompany.com", @first_name="Bob", @last_name="Anderson", @accounts=[], @franchisors=[]>]
```

#### .create

Creates a new user on the Rallio platform.

```ruby
# To create a user a hash with email, first_name and last_name keys must be
# supplied.
Rallio::User.create(user: { email: 'me@example.com', first_name: 'John', last_name: 'Doe' })
# => { user: { id: 100, first_name: 'John', last_name: 'Doe', email: 'me@example.com' } }
```

#### #sign_on_token

With an instantiated user object you can call to get a single sign-on token
for the given user. These tokens last for 5 minutes and allow the user to be
signed into the Rallio platform by visiting the given url.

```ruby
user
# => <Rallio::User @id=100, @email="bob@yourcompany.com", @first_name="Bob", @last_name="Anderson", @accounts=[], @franchisors=[]>

user.sign_on_token
# => <Rallio::SignOnToken @token="15ad86b2ede6", @expires_at=#<DateTime: 2015-04-16T23:5...,321000000n),+0s,2299161j)>, @url="https://app.rallio.com/api/internal/sign_on_tokens/15ad86b2ede6">
```

#### #access_token

With an instantiated user object you can call to get an access token for the
given user. These access tokens do not expire at the moment so it is recommended
that you store this and reuse the token.

```ruby
user
# => <Rallio::User @id=100, @email="bob@yourcompany.com", @first_name="Bob", @last_name="Anderson", @accounts=[], @franchisors=[]>

user.access_token
# => <Rallio::AccessToken @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @user_id=100, @expires_at=nil, @scopes="user_info basic_access">
```

#### #account_ownerships

Returns all the accounts this user is associated with.

```ruby
user.account_ownerships
# => [#<Rallio::AccountOwnership:0x007fc3aaaa70b0 @user_id=100, @account_id=200, @account_name="Awesome Haircuts New York City", @account_franchisor_id=300, @account_franchisor_name="Awesome Haircuts Franchisor 1">]
```

#### #franchisor_ownerships

Returns all the franchisors this user is associated with.

```ruby
user.franchisor_ownerships
# => [#<Rallio::FranchisorOwnership:0x007f93d8986340 @user_id=100, @franchisor_id=300, @franchisor_name="Awesome Haircuts Franchisor 1">]
```

#### #me

**NOTE:** This endpoint is in the docs but it appears it may not be implemented.
This will remain here until that is cleared up.

This calls out and gets the user info for a given id. All that is needed is to
instantiate an instance with a valid user id an calling me will pull the rest
of the information.

```ruby
user = Rallio::User.new(id: 100)
# => <Rallio::User @id=100, @email=nil, @first_name=nil, @last_name=nil, @accounts=[], @franchisors=[]>

user.me
# => <Rallio::User @id=100, @email="bob@yourcompany.com", @first_name="Bob", @last_name="Anderson", @accounts=[], @franchisors=[]>
```

### SignOnToken

#### .create

A sign-on token can also be created independently of a user object. Calling the
`SignOnToken.create` method with a user id will return a sign-on token for that
user.

```ruby
Rallio::SignOnToken.create(user_id: 100)
# => <Rallio::SignOnToken:0x007fa9d703b7d0 @token="15ad86b2ede6", @expires_at=#<DateTime: 2015-04-16T23:5...,321000000n),+0s,2299161j)>, @url="https://app.rallio.com/api/internal/sign_on_tokens/15ad86b2ede6">
```

### Access Token

#### .create

An access token can also be created independently of a user object. Calling the
`AccessToken.create` method with a user id will return an access token for that
user.

```ruby
Rallio::AccessToken.create(user_id: 100)
# => <Rallio::AccessToken:0x007fd3fc9fea70 @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @user_id=100, @expires_at=nil, @scopes="user_info basic_access">
```

#### #destroy

Destroys the access_token passed in for the object.

```ruby
access_token = Rallio::AccessToken.new(access_token: '4a25dd89e50bd0a0db1eeae65864fe6b')
# => <Rallio::AccessToken:0x007fd3fc9fea70 @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @user_id=nil, @expires_at=nil, @scopes=nil>

access_token.destroy                              # => true
```

### FranchisorOwnership

#### .for

Returns all franchisors for a given access token.

```ruby
Rallio::FranchisorOwnership.for(access_token: '4a25dd89e50bd0a0db1eeae65864fe6b')
# => [<Rallio::FranchisorOwnership:0x007f93d8986340 @user_id=100, @franchisor_id=300, @franchisor_name="Awesome Haircuts Franchisor 1">]
```

#### .create

This creates an association between a user and a Franchisor.

```ruby
Rallio::FranchisorOwnership.create(user_id: 100, franchisor_id: 300)
# => <Rallio::FranchisorOwnership:0x007f93d8986340 @user_id=100, @franchisor_id=300, @franchisor_name="Awesome Haircuts Franchisor 1">
```

#### .destroy

Destroys a relationship between user and franchisor.

```ruby
Rallio::FranchisorOwnership.destroy(user_id: 100, franchisor_id: 300)
# => {}
```

### AccountOwnership

#### .for

Returns all accounts for a given access token.

```ruby
Rallio::AccountOwnership.for(access_token: '4a25dd89e50bd0a0db1eeae65864fe6b')
# => [<Rallio::AccountOwnership:0x007fc3aaaa70b0 @user_id=100, @account_id=200, @account_name="Awesome Haircuts New York City", @account_franchisor_id=300, @account_franchisor_name="Awesome Haircuts Franchisor 1">]
```

#### .create

This creates an association between a user and an Account.

```ruby
Rallio::AccountOwnership.create(user_id: 100, account_id: 200)
# => <Rallio::AccountOwnership:0x007fc3aaaa70b0 @user_id=100, @account_id=200, @account_name="Awesome Haircuts New York City", @account_franchisor_id=300, @account_franchisor_name="Awesome Haircuts Franchisor 1">
```

#### .destroy

Destroys a relationship between user and account.

```ruby
Rallio::AccountOwnership.destroy(user_id: 100, account_id: 200)
# => {}
```

### Franchisor

#### .all

Returns all franchisors for a given set of app credentials.

```ruby
Rallio::Franchisor.all
# => [<Rallio::Franchisor:0x007fa944c30e48 @id=100, @name="Awesome Haircuts", @short_name=nil, @url=nil, @city=nil, @country_code=nil, @time_zone=nil>]
```

#### #accounts

Returns all accounts associated with a franchisor.

```ruby
franchisor = Rallio::Franchisor.new(id: 100)
# => <Rallio::Franchisor:0x007fa944c30e48 @id=100, @name=nil, @short_name=nil, @url=nil, @city=nil, @country_code=nil, @time_zone=nil>

franchisor.accounts
# => [<Rallio::Account:0x007f801bb0a610 @id=100, @name="Awesome Haircuts New York City", @short_name="AH-NYC", @url="https://awesomehaircuts.fake", @city="New York", @country_code="US", @time_zone="Eastern Time (US & Canada)">]
```

### Account

#### .for

Get all accounts for a given franchisor_id.

```ruby
accounts = Rallio::Account.for(franchisor_id: 200)
# => [<Rallio::Account:0x007f801bb0a610 @id=100, @name="Awesome Haircuts New York City", @short_name="AH-NYC", @url="https://awesomehaircuts.fake", @city="New York", @country_code="US", @time_zone="Eastern Time (US & Canada)">]
```

#### .created

Creates account for given franchisor_id.

```ruby
payload = {
  account: {
    name: 'Awesome Test Account',
    short_name: 'ATA-1',
    url: 'https://ata.example',
    city: 'Narnia',
    country_code: 'US',
    time_zone: 'Central Time (US & Canada)'
  }
}

Rallio::Account.create(franchisor_id: 200, payload: payload)
# => { account: { name: 'Awesome Test Account', short_name: 'ATA-1', url: 'https://ata.example', city: 'Narnia', country_code: 'US', time_zone: 'Central Time (US & Canada)' } }
```

#### #reviews

This is a convenience method to get reviews for a given account. All that is
needed is a `Rallio::Account` object instantiated with a valid account id. This
calls the `Rallio::Review.all` method to get reviews.

```ruby
user.access_token
# => <Rallio::AccessToken @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @user_id=100, @expires_at=nil, @scopes="user_info basic_access">

account = Rallio::Account.new(id: 9397)
# => <Rallio::Account:0x007ff4d8160f60 @id=9397, @name=nil>

account.reviews(access_token: user.access_token)
# => [<Rallio::Review:0x007fcf402de8f0 @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @id=227704, @account_id=9397, @account_name="Rally-O Tires New York", @network="facebook", @posted_at=#<DateTime: 2017-02-21T23:12:33+00:00 ((2457806j,83553s,0n),+0s,2299161j)>, @user_name="Andy Bobson", @user_image="https://graph.facebook.com/100009872044695/picture", @rating=5.0, @message="This is my favourite place to buy tires!", @comments=[{:user_name=>"Rally-O Tires New York", :user_image=>"https://graph.facebook.com/113397275345614/picture", :message=>"Thanks for the 5 star review!", :created_at=>"2017-02-22T00:49:53.000+00:00"}], @liked=true, @url="https://www.facebook.com/123123123", @can_reply=true, @location_name="Visiting Angels Newburyport MA", @location_image_url="https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/16266055_1428821143803214_8378119243787669723_n.jpg?oh=3268e6e30474a0aa488cfd896a6d6c06&oe=59357742", @review_reply=nil, @review_reply_at=nil>]
```

### Review

#### .all

This calls out to get all reviews for a given account or franchisor.

```ruby
# type: can be either of :accounts or :franchisors
# id: is the id for the account or franchisor
# access_token: is the access token for a Rallio::User
reviews = Rallio::Review.all(type: :accounts, id: 9397, access_token: user.access_token)
# => [<Rallio::Review:0x007fcf402de8f0 @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @id=227704, @account_id=9397, @account_name="Rally-O Tires New York", @network="facebook", @posted_at=#<DateTime: 2017-02-21T23:12:33+00:00 ((2457806j,83553s,0n),+0s,2299161j)>, @user_name="Andy Bobson", @user_image="https://graph.facebook.com/100009872044695/picture", @rating=5.0, @message="This is my favourite place to buy tires!", @comments=[{:user_name=>"Rally-O Tires New York", :user_image=>"https://graph.facebook.com/113397275345614/picture", :message=>"Thanks for the 5 star review!", :created_at=>"2017-02-22T00:49:53.000+00:00"}], @liked=true, @url="https://www.facebook.com/123123123", @can_reply=true, @location_name="Visiting Angels Newburyport MA", @location_image_url="https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/16266055_1428821143803214_8378119243787669723_n.jpg?oh=3268e6e30474a0aa488cfd896a6d6c06&oe=59357742", @review_reply=nil, @review_reply_at=nil>]
```

#### #reply

To reply to a review you need a Review object with and id and access_token
passed in. Then you can just call the `Rallio::Review#reply` method with the
text of your reply. **NOTE:** if you are using a review object obtained from a
call to `Rallio::Review.all` the access_token is populated for you.

```ruby
review = Rallio::Review.new(access_token: '4a25dd89e50bd0a0db1eeae65864fe6b', id: 227704)
# =><Rallio::Review:0x007fcf402de8f0 @access_token="4a25dd89e50bd0a0db1eeae65864fe6b", @id=227704, @account_id=nil, @account_name=nil, @network=nil, @posted_at=nil, @user_name=nil, @user_image=nil, @rating=nil, @message=nil, @comments=[], @liked=nil, @url=nil, @can_reply=nil, @location_name=nil, @location_image_url=nil, @review_reply=nil, @review_reply_at=nil>

review.reply("This is my reply")
# => {}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdguzman/rallio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
