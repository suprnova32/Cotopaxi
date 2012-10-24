require 'spec_helper'

describe Project do

  it {should validate_presence_of :name}

  it {should validate_presence_of :description}

  it {should have_many :features}

  it 'raises an error if saved empty' do
    project = Project.new
    expect{project.save!}.to raise_error ActiveRecord::RecordInvalid
  end

  it 'can include features' do
    project = Project.new
    project.name = "Test Name"
    project.description = "Test description"
    feature = Feature.new
    feature.project = project
    feature.name = 'Test Feat'
    feature.description = 'some desc'
    feature.save!
    project.features.should include feature
  end
end