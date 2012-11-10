require 'bundler'

require 'sinatra'
require 'sinatra/google-auth'

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

run App
