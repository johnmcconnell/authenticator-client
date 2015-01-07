# Authenticator::Client
[![Build Status](https://travis-ci.org/johnmcconnell/authenticator-client.svg?branch=master)]
(https://travis-ci.org/johnmcconnell/authenticator-client)
[![Coverage
Status](https://coveralls.io/repos/johnmcconnell/authenticator-client/badge.png?branch=master)](https://coveralls.io/r/johnmcconnell/authenticator-client?branch=master)

## Description
This gem is designed to be used with
[Account Authenticator](https://account-authenticator.herokuapp.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'authenticator-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install authenticator-client

## Usage

### Creating a client:

```
config = {
  api_key: 'api_key',
  api_password: 'api_password',
  host: 'http://account-authenticator.herokuapp.com'
}

Authenticator::Client.register_config(:config_key, config)
Authenticator::Client.new(:config_key)

```

### Creating an account:

```
client.create(Account.new(username, password))
#=> '{
  "id":6,
  "username":"new_username",
  "created_at":"2015-01-04T20:36:28.339Z",
  "updated_at":"2015-01-04T20:36:28.339Z"
}'
```

### Authenticating an account:

```
client.authenticate(account)
#=> '{"authenticated":true}'
```

### Reading accounts:

```
client.all
#=> '{"accounts":[
  { "id":6,
    "username":"new_username",
    "created_at":"2015-01-04T20:36:28.339Z",
    "updated_at":"2015-01-04T20:36:28.339Z" }
]}'

```

### Updating an account:

```
client.update(id, account)
#=> '{
  "id":7,
  "username":"new_username_1",
  "created_at":"2015-01-04T20:36:28.949Z",
  "updated_at":"2015-01-04T20:36:28.949Z"
}'
```

### Deleting an account:

```
client.destroy(id)
#=> '{"id":10}'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/authenticator-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
