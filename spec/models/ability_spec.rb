require 'spec_helper'

describe Ability do
  context 'with Project Object and roles' do
    before do
      @user = FactoryGirl.create(:user)
    end
    it 'Role is product_owner' do
      project = FactoryGirl.create(:project)
      project.roles << Role.new(role: :product_owner, project_id: project.id, user_id: @user.id)
      ability = Ability.new(@user, project.id)
      ability.can?(:manage, Project).should be true
    end

    it 'Role is scrum_master' do
      project = FactoryGirl.create(:project)
      project.roles << Role.new(role: :scrum_master, project_id: project.id, user_id: @user.id)
      ability = Ability.new(@user, project.id)
      ability.can?(:manage, Project).should be true
    end

    it 'Role is customer' do
      project = FactoryGirl.create(:project)
      project.customer_ids = @user.id
      ability = Ability.new(@user, project.id)
      ability.can?(:manage, Project).should be false
    end

    it 'Role is stakeholder' do
      project = FactoryGirl.create(:project)
      project.stakeholder_ids = @user.id
      ability = Ability.new(@user, project.id)
      ability.can?(:manage, Project).should be true
    end

    it 'Role is team_member' do
      project = FactoryGirl.create(:project)
      project.team_member_ids = @user.id
      ability = Ability.new(@user, project.id)
      ability.can?(:manage, Project).should be false
    end
  end
end
