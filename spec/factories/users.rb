# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  Patricio Cano
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

require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@localhost.com"
    end
    sequence :nickname do |n|
      "NiC#{n}"
    end
    password "testPassword"
    password_confirmation "testPassword"
  end

  factory :admin, class: User do |n|
    sequence :email do |n|
      "person#{n}@localhost.com"
    end
    sequence :nickname do |n|
      "NiC#{n}"
    end
    password "testPassword"
    password_confirmation "testPassword"
    stakeholder true
  end
end