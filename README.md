# Sinatra::GoogleAuth

Drop-in authentication for Sinatra with Google's OpenID endpoint.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-google-auth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-google-auth

## Usage

The gem exposes a single `authenticate` helper that protects the endpoint with
Google OpenID authentication.

As of version 0.0.7. you can also use `Sinatra::GoogleAuth::Middleware` to protect your whole app
and/or control where the authentication happens in a middleware chain.

### Middleware

```ruby
require 'sinatra/base'
require 'sinatra/google-auth'

class App < Sinatra::Base
  register Sinatra::GoogleAuth
  use Sinatra::GoogleAuth::Middleware

  get '*' do
    'hello'
  end
end
```

### Classic-Style Apps

```ruby
require 'sinatra'
require 'sinatra/google-auth'

get '*' do
  authenticate
  'hello'
end
```

### Modular Apps

```ruby
require 'sinatra/base'
require 'sinatra/google-auth'

class App < Sinatra::Base
  register Sinatra::GoogleAuth

  get '*' do
    authenticate
    'hello'
  end
end
```

## Doing something with the User

Define an `on_user` method in your app to do something with the user info after authentication.

```ruby
class App < Sinatra::Base
  register Sinatra::GoogleAuth

  def on_user(info)
    puts info.inspect
  end

  get '*' do
    authenticate
    'hello'
  end
end
```

## Configuration

### Google Endpoint

Configure your Google OpenID endpoint via setting the ENV var `GOOGLE_AUTH_URL`

    $ export GOOGLE_AUTH_URL=http://myurl.com/openid

or before requiring

```ruby
ENV['GOOGLE_AUTH_URL'] = 'http://myurl.com/openid'

require 'sinatra'
require 'sinatra/google-auth'
```

### Session Secret

Configure your session secret by setting `SESSION_SECRET` or `SECURE_KEY` ENV vars.


    $ export SESSION_SECRET='super secure secret'

The 'SecureKey' add-on sets the `SECURE_KEY` variable for you and automatically rotates it.

    $ heroku addons:add securekey


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
