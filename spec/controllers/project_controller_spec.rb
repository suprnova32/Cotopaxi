require 'spec_helper'

describe ProjectsController do
  context "create & show fictional project" do
    before do
      project = Project.new
      project.name = "Test Name"
      project.description = "Test description"
      project.save!
      get :show, id: 1
    end

    it { should respond_with :success }
    it { should render_template :show }
    it { should_not set_the_flash }
  end

  context "show projects' index" do
    before do
      get :index
    end

    it { should respond_with :success }
    it { should render_template :index }
    it { should_not set_the_flash }
  end
end