require 'spec_helper'

describe User do
  it {should validate_presence_of :email}

  it {should validate_presence_of :nickname}

  it {should validate_presence_of :password}

  it {should have_many :projects}

  it {should have_many :roles}

  it 'raises an error if saved empty' do
    user = User.new
    expect{user.save!}.to raise_error ActiveRecord::RecordInvalid
  end
end
