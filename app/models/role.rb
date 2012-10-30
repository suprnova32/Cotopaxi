class Role < ActiveRecord::Base
  attr_accessible :role, :user_id, :project_id
  belongs_to :user
  belongs_to :project

  def multiple_choice
    case self.role
      when 'team_member'
        true
      when 'customer'
        true
      when 'stakeholder'
        true
      else
        false
    end

  end
end
