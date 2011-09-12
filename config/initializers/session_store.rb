# Be sure to restart your server when you modify this file.

# Quby::Application.config.session_store :cookie_store, :key => '_quby_session'

unless Rails.env.development?
  Quby::Application.config.session_store :active_record_store, :key => '_quby_ar_session', :domain => '.roqua.nl'
else
  Quby::Application.config.session_store :active_record_store, :key => '_quby_ar_session'
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Rails.application.config.session_store :active_record_store
