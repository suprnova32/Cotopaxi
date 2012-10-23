require 'spec_helper'

describe Project do

  it 'is invalid without a name' do
    project = Project.new
    project.description = "Test description"
    project.should_not be_valid
  end

  it 'is invalid without a description' do
    project = Project.new
    project.name = "Test Name"
    project.should_not be_valid
  end

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
    project.features.should include(feature)
  end
end