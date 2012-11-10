require 'bundler'

require 'sinatra/base'
require 'sinatra/google-auth'

class App < Sinatra::Base
  register Sinatra::GoogleAuth
  use Sinatra::GoogleAuth::Middleware

  get '*' do
    'hello'
  end
end

run App
