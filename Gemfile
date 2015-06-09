source 'http://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Use sqlite3 as the database for Active Record
group :development, :test do 
  gem 'rspec-rails', '~> 3.0.0'
  gem 'bullet'
end

gem 'pg', '~> 0.18.0.pre20141117110243'

# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sass-rails', '>= 3.2'
gem 'autoprefixer-rails'
# Bootswatch Template
gem 'bootswatch-rails'

gem 'devise'
gem 'will_paginate', '~> 3.0.5'
gem 'will_paginate-bootstrap'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'american_date'
gem 'active_record_union'
gem 'browser-timezone-rails'

# Test Suite
group :test do 
	gem 'selenium-webdriver'
	gem 'capybara'
	gem 'launchy'
	gem 'factory_girl_rails'
	gem 'database_cleaner', github: 'bmabey/database_cleaner'
end

# For heroku (ensures that asset pipeline is correctly used)
group :production, :staging do
	gem 'rails_12factor'
end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-ui-themes'
gem 'font-awesome-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
