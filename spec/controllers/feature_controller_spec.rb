require 'spec_helper'

describe FeaturesController do

  context "display add features" do
    before do
      project = Project.new
      project.name = "Test Name"
      project.description = "Test description"
      project.save!
      feature = Feature.new
      feature.name = "test feature"
      feature.description = "something"
      feature.project = project
      feature.difficulty = 3
      feature.save!
      get :new, project_id: 1
    end
    it { should respond_with :success }
    it { should render_template :new }
    it { should_not set_the_flash }

    context "display features index" do
      before do
        get :index, project_id: 1
      end
      it { should respond_with :success }
      it { should render_template :index }
      it { should_not set_the_flash }
    end

    context "display edit feature" do
      before do
        get :edit, project_id: 1, id: 1
      end
      it { should respond_with :success }
      it { should render_template :edit }
      it { should_not set_the_flash }
    end
  end
end