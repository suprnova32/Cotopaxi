class Ability
  include CanCan::Ability

  def initialize(user, project_id)

    if user.stakeholder
      can :manage, :all
    else
      role = user.roles.find_by_project_id(project_id)
      if role != nil
        case role.role
          when 'product_owner'
            can :manage, [Project, Feature, Sprint]
            can [:prioritize_feature,:assign_roles], Project
            can :manage, User, id: user.id
          when 'scrum_master'
            can :manage, [Project, Feature]
            can :manage, User, id: user.id
          when 'customer'
            can :read, [Project, Feature]
            can :create, Feature
            can :manage, User, id: user.id
          when 'stakeholder'
            can :manage, Project
            can [:create, :read], Feature
            can :manage, User, id: user.id
          when 'team_member'
            can :read, Project
            can :create, Feature
            can :manage, User, id: user.id
        end
      else
        can :read, [Project, Feature]
        can :manage, User, id: user.id
      end
    end
  end
end
