[![Code Climate](https://codeclimate.com/github/jdguzman/rallio/badges/gpa.svg)](https://codeclimate.com/github/jdguzman/rallio)
[![Build Status](https://travis-ci.org/jdguzman/rallio.svg?branch=master)](https://travis-ci.org/jdguzman/rallio)

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

#### Accessible Users

The user class can be used to access all available users for a given
application.

```ruby
Rallio::User.accessible_users
# =>
# [<Rallio::User:0x007fc325b36808 @id=100, @email="bob@yourcompany.com", @first_name="Bob", @last_name="Anderson", @accounts=[], @franchisors=[]>]
```

#### Single Sign-on Tokens

With an instantiated user object you can call to get a single sign-on token
for the given user.

```ruby
user
# => <Rallio::User:0x007fc325b36808 @id=100, @email="bob@yourcompany.com", @first_name="Bob", @last_name="Anderson", @accounts=[], @franchisors=[]>

user.sign_on_tokens
# => <Rallio::SignOnToken:0x007fb915beb948 @token="15ad86b2ede6", @expires_at=#<DateTime: 2015-04-16T23:5...,321000000n),+0s,2299161j)>, @url="https://app.rallio.com/api/internal/sign_on_tokens/15ad86b2ede6">
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdguzman/rallio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
