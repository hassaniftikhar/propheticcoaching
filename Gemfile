source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '5.0.0'

#group :assets do
gem 'sass-rails', '~> 5.0.5'
gem 'coffee-rails', '~> 4.1.1'
gem 'uglifier', '>= 1.0.3'
gem 'less-rails', '>= 2.4.2'
gem 'therubyracer', :platform=>:ruby
#end

gem 'twitter-bootstrap-rails', '>= 2.2.8'
gem 'jquery-rails', '>= 4.0.1'
gem 'cancan'
gem 'devise', '>= 4.0.0'
gem 'figaro', '>= 1.0.0'
gem 'mysql2'
gem 'rolify'
gem 'simple_form', '>= 3.2.1'
gem 'rmagick'
gem 'mini_magick'
#gem 'chosen-rails'
#gem "chartkick"
#gem 'groupdate'
#gem "active_median"
#gem 'uglifier', '>= 1.3.0'
#gem 'coffee-rails', '~> 4.0.0'
#gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'fog'
gem "paperclip", "~> 3.5.1"
gem "pdf-reader"
gem "tire"
gem "gon", ">= 4.1.1"
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'paper_trail', '~> 3.0.0'
gem 'redis'
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem 'rails_12factor'
# gem 'resque'
gem 'unf' 
gem 'resque', '>= 1.25.2', :require => 'resque/server'
gem 'country_select'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'quiet_assets', '>= 1.0.2'
  #gem 'sqlite3'
  # gem 'pg'
  gem 'active_record_query_trace'
end
group :development, :test do
  gem 'factory_girl_rails', '>= 4.3.0'
  gem 'rspec-rails', '>= 2.14.0'
  gem 'thin', '>= 1.6.1'
end
group :production do
  #gem 'unicorn'
  gem "thin", ">= 1.6.1"
  gem 'pg'
end
group :test do
  gem 'capybara', '>= 2.2.0'
  gem 'cucumber-rails', '>= 1.4.0', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'poltergeist', '>= 1.5.1'
end
