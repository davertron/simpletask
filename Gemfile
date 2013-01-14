source 'http://rubygems.org'

# NOTE: Do NOT change versions here and do a bundle install; if you're changing
# a gem, then do a "bundle update <gem>" instead, to avoid problems with other
# gems.

gem 'rails', '3.1.10'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# NOTE: for some reason mongo 1.8.0 will break and not start in passenger.
gem "mongo", "~> 1.7.1"
gem 'mongo_mapper'
gem 'bson_ext'

gem 'sorcery'

gem 'will_paginate', '~> 3.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  = 3.1.4"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
