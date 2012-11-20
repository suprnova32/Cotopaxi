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

require 'spec_helper'
require 'factory_girl'

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
      @project = FactoryGirl.create(:project)
      @user = FactoryGirl.create(:user)
      @project.roles << Role.new(role: :product_owner, project_id: @project.id, user_id: @user.id)
      @project.roles << Role.new(role: :scrum_master, project_id: @project.id)
      @feature = FactoryGirl.build(:feature)
      @feature.project = @project
      @feature.save!
    end
    it 'can include features' do
      @project.features.should include @feature
    end

    it 'can assign roles and have ability' do
      params = {id: "1", project_id: "1", role: "scrum_master", user_id: "1"}
      @project.project_ability(@user).should be_a_kind_of Ability
      @project.assign_roles(params).should be true
    end

    it 'evaluates sprint button text' do
      @sprint = Sprint.new
      @sprint.state = 'foo'
      @project.sprints << @sprint
      @project.next_sprint_text.should eq 'Plan Sprint'
    end

    it 'can get unassigned features' do
      @project.get_unassigned_features.should be_a_kind_of Array
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