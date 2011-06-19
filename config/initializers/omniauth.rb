# -*- encoding : utf-8 -*-
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'],
                      {:scope => 'email, offline_access', 
                      :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
  provider :linked_in, ENV['LD_KEY'], ENV['LD_SECRET']
  provider :github, ENV['GH_ID'], ENV['GH_SECRET']
end
