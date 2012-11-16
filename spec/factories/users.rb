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