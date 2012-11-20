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

feature "Projects & their features with login" do
  background do
    @user = FactoryGirl.create(:admin)
    visit '/users/sign_in'
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "testPassword"
    click_button "Sign in"
    @project = FactoryGirl.build(:project)
    @project.roles << Role.new(role: :product_owner, project_id: @project.id, user_id: @user.id)
    @project.roles << Role.new(role: :scrum_master, project_id: @project.id)
    @project.save!
    feature = FactoryGirl.build(:feature)
    feature.difficulty = 3
    feature.project = @project
    feature.save!
  end

  scenario "GET /users" do
    visit '/users'
    page.should have_content "NiC"
  end

  scenario "GET /projects" do
    visit '/projects'
    page.should have_content "Test Name"
  end

  scenario "GET /projects/new" do
    visit '/projects/new'
    fill_in "Name", with: "Second Project"
    fill_in "Description", with: "Description for this project"
    click_button "Create Project"
    page.should have_content 'Project was successfully created.'
    page.should have_content 'Second Project'
  end

  scenario "GET /projects/1 and add a feature" do
    visit '/projects/1'
    click_link "New Feature"
    fill_in "Name", with: "New feature"
    fill_in "Description", with: "Description of feature."
    click_button "Create Feature"
    page.should have_content 'Feature was successfully created.'
    page.should have_content 'New feature'
  end

  scenario "GET /projects/1 and delete a feature" do
    visit '/projects/1/features/1'
    click_link "Delete"
    page.should have_content 'Feature was successfully deleted.'
  end

  scenario "GET /projects and delete a project" do
    visit '/projects/1'
    click_link 'deleteP'
    page.should have_content 'Project was successfully deleted.'
  end

  scenario "GET /projects/1 and cycle the state machine" do
    visit '/projects/1'
    click_link 'projectState'
    page.should have_content 'Project was successfully updated.'
    page.should have_content 'In progress'
    click_link 'Complete!'
    page.should have_content 'Done'
  end

  scenario "GET /projects/1/features and cycle the state machine" do
    visit '/projects/1/features'
    click_link 'Start!'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'In progress'
    visit '/projects/1/features'
    click_link 'Complete!'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'Done'
  end

  scenario "GET /projects/1 and update it" do
    visit '/projects/1'
    click_link 'Edit Project'
    fill_in "Description", with: "Updated description!"
    click_button 'Update Project'
    page.should have_content 'Project was successfully updated.'
    page.should have_content 'Updated description!'
  end

  scenario "GET /projects/1/features/1 and update it" do
    visit '/projects/1/features/1'
    page.should have_content 'Medium'
    click_link 'editF'
    fill_in "Description", with: "Updated description!"
    click_button 'Update Feature'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'Updated description!'
  end

  scenario "GET /projects/1 create a sprint and start it" do
    visit '/projects/1'
    click_link 'Plan Sprint'
    page.should have_content 'Sprint number: 1'
    click_link 'Begin Sprint!'
    page.should have_content 'Sprint was successfully updated.'
  end

  scenario "GET /projects/1 and create a second sprint" do
    sprint = Sprint.new
    sprint.project = @project
    sprint.state = 'done'
    sprint.save!
    visit '/projects/1'
    click_link 'Plan Next Sprint'
    page.should have_content 'Sprint number: 2'
    click_link 'Back'
    page.should have_content "Test description"
    click_link 'Review Current Sprint'
    page.should have_content 'Created'
  end

end