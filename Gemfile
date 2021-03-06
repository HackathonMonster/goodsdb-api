source 'https://rubygems.org'

# Rails
gem 'rails', '4.1.8'
gem 'rails-i18n'

# Database
gem 'pg'
gem 'flag_shih_tzu'

# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

# API
gem 'jbuilder', '~> 2.0'
gem 'yajl-ruby'

# Facebook
gem 'koala'

# Settings
gem 'settingslogic'
gem 'figaro'

# File upload
gem 'carrierwave'
gem 'cloudinary'
gem 'carrierwave_backgrounder'

# Workers
gem 'sidekiq'

# Misc
gem 'docomo_image_recognition'
gem 'acts_as_votable'

gem 'puma'

group :development, :test do
  gem 'jazz_hands', github: 'jkrmr/jazz_hands'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'polyglot_faker'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'annotate', require: false
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'debase'
  gem 'ruby-debug-ide'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'json_spec'
  gem 'shoulda-matchers', require: false
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
  gem 'capistrano-sidekiq'
end
