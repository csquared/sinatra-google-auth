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

    def self.secret
      ENV['SESSION_SECRET'] || ENV['SECURE_KEY'] || 'please change me'
    end

    def self.registered(app)
      raise "Must supply ENV var GOOGLE_AUTH_URL" unless ENV['GOOGLE_AUTH_URL']
      app.helpers GoogleAuth::Helpers
      app.use ::Rack::Session::Cookie, :secret => secret
      app.use ::OmniAuth::Strategies::OpenID, :name => "google", :identifier => ENV['GOOGLE_AUTH_URL']

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
