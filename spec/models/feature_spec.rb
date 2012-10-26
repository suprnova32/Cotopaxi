require 'spec_helper'

describe Feature do

  it {should validate_presence_of :name}

  it {should validate_presence_of :description}

  it {should belong_to :project}

  it 'raises an error if saved empty' do
    feature = Feature.new
    expect{feature.save!}.to raise_error ActiveRecord::RecordInvalid
  end


end