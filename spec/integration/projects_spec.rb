require 'spec_helper'

feature "Projects" do
  background do
    project = Project.new
    project.name = "Test Name"
    project.description = "Test description"
    project.save!
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
    click_link "Add Feature"
    fill_in "Name", with: "New feature"
    fill_in "Description", with: "Description of feature."
    click_button "Create Feature"
    page.should have_content 'Feature was successfully created.'
    page.should have_content 'New feature'
  end
end