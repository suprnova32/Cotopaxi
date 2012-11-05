require 'spec_helper'

feature "Projects & their features with login" do
  background do
    user = User.new
    user.nickname = 'AdM'
    user.email = 'admin@goole.com'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.save!
    visit '/users/sign_in'
    fill_in "user_email", with: "admin@goole.com"
    fill_in "user_password", with: "password"
    click_button "Sign in"
    project = Project.new
    project.name = "Test Name"
    project.description = "Test description"
    project.roles << Role.new(role: :product_owner, project_id: project.id, user_id: user.id)
    project.roles << Role.new(role: :scrum_master, project_id: project.id)
    project.save!
    feature = Feature.new
    feature.name = "test feature"
    feature.description = "something"
    feature.project = project
    feature.difficulty = 3
    feature.save!
  end

  scenario "GET /users" do
    visit '/users'
    page.should have_content "AdM"
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
    visit '/projects/1'
    click_link "Delete"
    page.should have_content 'Feature was successfully deleted.'
  end

  scenario "GET /projects and delete a project" do
    visit '/projects'
    click_link 'Delete'
    page.should have_content 'Project was successfully deleted.'
  end

  scenario "GET /projects/1 and cycle the state machine" do
    visit '/projects/1'
    click_link 'Start!'
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
    click_link 'Edit'
    fill_in "Description", with: "Updated description!"
    click_button 'Update Feature'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'Updated description!'
  end
end