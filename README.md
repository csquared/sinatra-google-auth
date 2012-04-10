# Sinatra::Google::Auth

Drop


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

Configure your google openid endpoint via setting the ENV var: GOOGLE_AUTH_URL

### Classic-Style Apps

```ruby
require 'sinatra/base
require 'sinatra/google-auth'

get '*' do
  authenticate
  'hello'
end
```


### Modular Apps

```ruby
require 'sinatra/base
require 'sinatra/google-auth'

class App < Sinatra::Base
  register Sinatra::GoogleAuth

  get '*' do
    authenticate
    'hello'
  end
end
```




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
