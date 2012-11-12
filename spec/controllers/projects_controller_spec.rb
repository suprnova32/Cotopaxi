require 'spec_helper'
require "factory_girl"

describe ProjectsController do
  context "create & show fictional project" do
    before do
      @user = Factory(:user)#User.new
      #@user.nickname = 'AdM'
      #@user.email = 'admin@goole.com'
      #@user.password = 'password'
      #@user.password_confirmation = 'password'
      #@user.stakeholder = true
      @user.save!
      sign_in @user
      project = Project.new
      project.name = "Test Name"
      project.description = "Test description"
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
      @user = User.new
      @user.nickname = 'ScA'
      @user.email = 'admin@goole.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.stakeholder = false
      @user.save!
      sign_in @user
      get :new
    end
    it { should set_the_flash }
    it { should redirect_to projects_url}
  end
end