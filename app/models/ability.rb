# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  MHM-Systemhaus GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
