class Ability
  include CanCan::Ability

  def initialize(user, project_id)
    #user ||= User.new # guest user (not logged in)

    if user.nickname == "AdM"
      can :manage, :all
    else
      role = user.roles.find_by_project_id(project_id)
      if role != nil
        case role.role
          when 'product_owner'
            can :manage, Project
            can :manage, Feature
          when 'scrum_master'
            can :manage, Project
            can :manage, Feature
          when 'customer'
            can :read, Project
          when 'stakeholder'
            can :read, Project
            can :read, Feature
          when 'team_member'
            can :read, Project
            can :manage, Feature
          else
            can :read, :all
        end
      else
        can :read, :all
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
