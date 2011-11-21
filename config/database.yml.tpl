# SQLite version 3.x
#   gem install sqlite3-ruby (not necessary on OS X Leopard)
development:
  adapter: mysql2
  database: quby_development
  username: root
  password: 
  encoding: utf8
  host: localhost

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test: &TEST
  adapter: mysql2
  database: quby_test
  username: root
  password: 
  encoding: utf8
  host: localhost

production:
  adapter: mysql2
  database: quby
  username: root
  password: 
  encoding: utf8
  host: localhost
