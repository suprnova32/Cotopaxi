require 'spec_helper'
require "factory_girl"

describe ProjectsController do
  context "create & show fictional project" do
    before do
      @user = FactoryGirl.create(:admin)
      sign_in @user
      project = FactoryGirl.build(:project)
      project.roles << Role.new(role: :product_owner, project_id: project.id, user_id: @user.id)
      project.roles << Role.new(role: :scrum_master, project_id: project.id)
      project.save!
      get :show, id: 1
    end

    it { should respond_with :success }
    it { should render_template :show }
    it { should_not set_the_flash }

    context "show edit projects form" do
      before do
        sign_in @user
        get :edit, id: 1
      end
      it {should }
      it { should respond_with :success }
      it {should render_template :edit}
      it { should_not set_the_flash }
    end

    context "show projects' index" do
      before do
        sign_in @user
        get :index
      end

      it { should respond_with :success }
      it { should render_template :index }
      it { should_not set_the_flash }
    end
  end

  context 'test for CanCan exception' do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get :new
    end
    it { should set_the_flash }
    it { should redirect_to projects_url}
  end
end