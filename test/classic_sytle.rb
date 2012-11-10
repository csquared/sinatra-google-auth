require 'bundler'

require 'sinatra'
require 'sinatra/google-auth'

get '*' do
  authenticate
  'hello'
end
