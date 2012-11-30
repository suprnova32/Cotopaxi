# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  MHM-Systemhaus GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'license_finder', git: "https://github.com/pivotal/LicenseFinder.git"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'mysql2'
  gem 'pg'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'capybara'
  gem 'sqlite3'
end

gem 'jquery-rails'
gem 'devise'
gem 'factory_girl_rails'
gem 'formtastic-bootstrap'
gem 'haml-rails'
gem 'state_machine'
gem 'cancan'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'

# To use debugger
# gem 'debugger'
