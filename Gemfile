source "https://rubygems.org"

ruby "3.4.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5", ">= 7.1.5.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"


# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem 'solargraph'
gem 'rufo'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.13'
gem 'bundler'

gem "bootstrap", "~> 5.3"
gem 'devise', '~> 4.8'
# Gestion langue FR pour Devise:
gem 'devise-i18n'
gem "autoprefixer-rails"

#front:
gem 'font-awesome-sass', '~> 6.7', '>= 6.7.2'
gem "simple_form", github: "heartcombo/simple_form"
gem 'sass-rails', '~> 6.0'
gem 'sassc', '~> 2.4'

# pagination des articles:
gem 'kaminari'
gem 'rubocop'
# gestion miniatures img:

gem 'activerecord-session_store'
gem 'omniauth', '~> 2.0'
gem 'omniauth-google-oauth2', '~> 1.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'rack', '~> 3.1', '>= 3.1.9'
# Gestion des URL pour le SEO:
gem 'friendly_id', '~> 5.4.0'
# Mise en page des articles:
gem 'tinymce-rails', '~> 4.3', '>= 4.3.13'
# Gestion des cookies:
gem 'cookies_eu', '~> 1.7', '>= 1.7.8'
# Validation active storage
gem 'active_storage_validations'
gem 'rake'
gem 'jquery-rails'


group :development, :test do
  gem "dotenv-rails"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
