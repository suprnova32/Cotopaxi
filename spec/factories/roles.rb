# Read about factories at https://github.com/thoughtbot/factory_girl
require 'factory_girl'

FactoryGirl.define do
  factory :role do
    role "MyString"
  end
end
