require 'factory_girl'

FactoryGirl.define do
  factory :project do
    name "Test Name"
    description "Test description"
  end
end