require 'spec_helper'

describe Project do

  it {should validate_presence_of :name}

  it {should validate_presence_of :description}

  it {should have_many :features}

  it {should have_many :stakeholders}

  it {should have_many :team_members}

  it {should have_many :users}

  it {should have_many :customers}

  it {should respond_to "get_unassigned_features", "assign_roles", "features_done?", "project_ability"}

  it 'raises an error if saved empty' do
    project = Project.new
    expect{project.save!}.to raise_error ActiveRecord::RecordInvalid
  end

  context "with Project Object" do
    before do
      @project = Project.new
      @project.name = "Test Name"
      @project.description = "Test description"
      @project.save!
      @feature = Feature.new
      @feature.project = @project
      @feature.name = 'Test Feat'
      @feature.description = 'some desc'
      @feature.save!
    end
    it 'can include features' do
      @project.features.should include @feature
    end

    it 'should return String methods' do
      @project.set_title_background.should be_a_kind_of String
      @project.set_state_change_button.should be_a_kind_of String
      @project.set_state_transition.should be_a_kind_of Symbol
      @project.set_disabled_button.should be_a_kind_of String
      @project.set_status_label.should be_a_kind_of String
      @project.complete_button.should be_a_kind_of String
      @project.drag_available.should be_a_kind_of String
      @project.disable_new_feature.should be_a_kind_of String
      @project.next_sprint_text.should be_a_kind_of String
    end
  end


end