require 'bundler'

require 'sinatra/base'
require 'sinatra/google-auth'

class Admin < Sinatra::Base
  register Sinatra::GoogleAuth
  use Sinatra::GoogleAuth::Middleware

  get '*' do
    'welcome to the admin section'
  end
end

class App < Sinatra::Base
  get '/' do
    "Public facing part"
  end
end

map("/") { run App }
map("/admin") { run Admin }
