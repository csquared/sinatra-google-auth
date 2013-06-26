# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sinatra/google-auth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Continanza"]
  gem.email         = ["christopher.continanza@gmail.com"]
  gem.description   = %q{Drop-in google auth for sinatra apps}
  gem.summary       = %q{Helpers and routes for google open-id authentication for Sinatra.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sinatra-google-auth"
  gem.require_paths = ["lib"]
  gem.version       = Sinatra::GoogleAuth::VERSION

  gem.add_dependency 'omniauth-google-apps'
  gem.add_dependency 'ruby-openid'
end
