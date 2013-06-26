require 'omniauth-google-apps'
require 'openid/store/filesystem'

module Sinatra
  module GoogleAuth

    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        if env['rack.session']["user"] || env['REQUEST_PATH'] =~ /\/auth\/google_apps/
          @app.call(env)
        else
          env['rack.session']['google-auth-redirect'] = env['REQUEST_PATH']
          location = File.join(env['REQUEST_PATH'], '/auth/google_apps')
          return [301, {'Content-Type' => 'text/html', 'Location' => location}, []]
        end
      end
    end

    module Helpers
      def authenticate
        unless session["user"]
          session['google-auth-redirect'] = request.path
          if settings.absolute_redirect?
            redirect "/auth/google_apps"
          else
            redirect to "/auth/google_apps"
          end
        end
      end

      def handle_authentication_callback
        unless session["user"]
          user_info = request.env["omniauth.auth"].info
          on_user(user_info) if respond_to? :on_user
          session["user"] = Array(user_info.email).first.downcase
        end

        url = session['google-auth-redirect'] || to("/")
        redirect url
      end
    end

    def self.secret
      ENV['SESSION_SECRET'] || ENV['SECURE_KEY'] || 'please change me'
    end

    def self.registered(app)
      raise "Must supply ENV var GOOGLE_AUTH_DOMAIN" unless ENV['GOOGLE_AUTH_DOMAIN']
      app.helpers GoogleAuth::Helpers
      app.use ::Rack::Session::Cookie, :secret => secret
      app.use OmniAuth::Strategies::GoogleApps, :domain => ENV['GOOGLE_AUTH_DOMAIN'], :store => nil

      app.set :absolute_redirect, false

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
