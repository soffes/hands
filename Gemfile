source 'https://rubygems.org'

gemspec

# Utility
gem 'rake', :group => [:development, :test]

# Documentation
group :development do
  gem 'yard'
  gem 'redcarpet', :platform => :ruby
end

# Testing
group :test do
  gem 'minitest'
  gem 'minitest-wscolor' if RUBY_VERSION >= '1.9.3'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
end
