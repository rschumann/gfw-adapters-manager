source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '>= 5.0.0.beta4', '< 5.1'

gem 'pg', '~> 0.18'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'

gem 'slim-rails'
gem 'simple_form'
gem 'kaminari'
gem 'oj',            require: false
gem 'oj_mimic_json', require: false
gem 'curb',          require: false

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  gem 'rspec-rails', '3.5.0.beta2'
  gem 'byebug'
  gem 'faker'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'brakeman', require: false
  gem 'annotate'
end

group :test do
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
end

# Server
gem 'puma'
gem 'foreman'
gem 'dotenv-rails'
gem 'redis', '~> 3.2'
gem 'redis-namespace'
gem 'rails_12factor', group: :production
