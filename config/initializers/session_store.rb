# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_quby2_session',
  :secret      => '3bd3f75c5ce19a06128209c7add56e974f34d4f8e341b0a01e89c037c5148fef19d708d011adc747249d879ab94b388c0622ffb3f262516d180498abd2e8d73b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
