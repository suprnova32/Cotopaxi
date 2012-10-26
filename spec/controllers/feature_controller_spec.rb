require 'spec_helper'

describe FeaturesController do

  context "display add features" do
    before do
      project = Project.new
      project.name = "Test Name"
      project.description = "Test description"
      project.save!
      get :new, project_id: 1
    end
    it { should respond_with :success }
    it { should render_template :new }
    it { should_not set_the_flash }
  end
end