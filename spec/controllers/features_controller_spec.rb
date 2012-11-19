require 'spec_helper'

describe FeaturesController do

  context "display add features" do
    before do
      @user = FactoryGirl.create(:admin)
      sign_in @user
      project = FactoryGirl.build(:project)
      project.roles << Role.new(role: :product_owner, project_id: project.id, user_id: @user.id)
      project.roles << Role.new(role: :scrum_master, project_id: project.id)
      project.save!
      feature = FactoryGirl.build(:feature)
      feature.difficulty = 3
      feature.project = project
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

    context "POST" do
      def do_request
        project = FactoryGirl.create(:project)
        post :create, {"feature"=>{"name"=>"Test 1", "description"=>"Test1", "difficulty"=>"3"}, "project_id"=>project.id}
      end
      context "create" do
        context "success" do
          before {do_request}
          it {should assign_to :feature}
          it { should respond_with :redirect }
        end

        context 'failure' do
          before do
            Feature.any_instance.stub(:save).and_return false
            do_request
          end
          it {should render_template :new}
        end
      end

      context "update" do
        def update_request
          project = FactoryGirl.create(:project)
          feature = FactoryGirl.build(:feature)
          feature.difficulty = 3
          feature.project = project
          feature.save!
          post :update, {"feature"=>{"name"=>"Test 1", "description"=>"Test1", "difficulty"=>"7"}, "project_id"=>project.id, "id" => feature.id}
        end
        context "success" do
          before {update_request}
          it {should assign_to :feature}
          it { should respond_with :redirect }
        end

        context 'failure' do
          before do
            Feature.any_instance.stub(:save).and_return false
            update_request
          end
          it {should render_template :edit}
        end
      end
    end
  end
end