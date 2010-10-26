# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_guidelines_parat_session',
  :secret      => '96dd5225b073434df777ad28bea0a8dc96dc09087ae37c34fd146cc1c39cfd4ecc9caf5d7aaf3c03a97fd76433dee54c9be5d1764d7dd061c3ffad5c5a10d6a4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
