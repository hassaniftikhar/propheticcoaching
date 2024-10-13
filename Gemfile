source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '7.0.0'

#group :assets do
gem 'sass-rails', '~> 6.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.0.3'
gem 'less-rails'
gem 'therubyracer', :platform=>:ruby
#end

gem 'twitter-bootstrap-rails', '>= 3.2.2'
gem 'jquery-rails'
gem 'cancan'
gem 'devise'
gem 'figaro', '>= 1.0.0'
gem 'mysql2'
gem 'rolify'
gem 'simple_form'
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
gem 'fog', '>= 1.37.0'
gem "paperclip", "~> 3.5.1"
gem "pdf-reader"
gem "tire"
gem "gon"
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'paper_trail', '~> 3.0.0'
gem 'redis'
gem 'carrierwave', '>= 2.2.6'
gem 'carrierwave_backgrounder'
gem 'rails_12factor'
# gem 'resque'
gem 'unf' 
gem 'resque', '>= 2.2.1', :require => 'resque/server'
gem 'country_select'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'quiet_assets'
  #gem 'sqlite3'
  # gem 'pg'
  gem 'active_record_query_trace'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
end
group :production do
  #gem 'unicorn'
  gem "thin"
  gem 'pg'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', '>= 3.0.0', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'poltergeist'
end
