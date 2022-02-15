source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass", "3.4.1"
gem "bcrypt", ">= 2.1.4"
gem "config"
gem "factory_bot_rails"
gem "faker", "2.1.2"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5.2"
gem "pagy"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.4", ">= 6.0.4.4"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "simplecov-rcov"
gem "simplecov"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
  gem "rspec-rails", "~> 5.0.0"
  gem "rails-controller-testing"
  gem "shoulda-matchers", "~> 5.0"
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
