source 'http://rubygems.org'

gem 'rails', '3.1.8'
gem "thin", "~> 1.4.1"
gem 'mysql2', '~> 0.3.0'
gem 'haml'
gem "simple_form", "~> 1.5.2"
gem 'cancan'
gem "devise", "~> 1.5.3"
gem 'comma' # Adds the comma macro to active record for csv export
gem 'whenever' # Cron job handling
gem 'jquery-rails'
gem 'prawn' # PDF
gem 'prawn_rails'

gem 'paginate_alphabetically', :git => 'git://github.com/edendevelopment/paginate_alphabetically.git', :branch => 'bundler' # Alphabetical pagination
gem 'kaminari' # Pagination
gem 'sorted' # Sorting stuff

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem "capistrano", "~> 2.11.2" # Deployment


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'faker'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec-rails'
  gem 'spork'
  gem 'autotest-standalone'
  gem "autotest-fsevent", "~> 0.2.8"
  gem 'autotest-growl'
  gem 'factory_girl_rails'
  gem 'cucumber-rails'
  gem 'webrat'
  gem 'database_cleaner'
  gem 'launchy'
end
