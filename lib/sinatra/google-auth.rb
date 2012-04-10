require 'omniauth-openid'

module Sinatra
  module GoogleAuth

    module Helpers
      def authenticate
        unless session["user"]
          redirect to "/auth/google"
        end
      end

      def handle_authentication_callback
        unless session["user"]
          user_info = request.env["omniauth.auth"].info
          session["user"] = Array(user_info.email).first.downcase
        end

        redirect to "/"
      end
    end

    def self.registered(app)
      app.helpers GoogleAuth::Helpers
      app.use ::Rack::Session::Cookie, :secret => ENV['SESSION_SECRET'] || SecureRandom.hex(64)
      app.use ::OmniAuth::Strategies::OpenID, :name => "google", :identifier => "http://heroku.com/openid" 

      app.get "/auth/:provider/callback" do
        handle_authentication_callback
      end

      app.post "/auth/:provider/callback" do
        handle_authentication_callback
      end
    end
  end

  register GoogleAuth
end

