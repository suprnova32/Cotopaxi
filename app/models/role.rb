class Role < ActiveRecord::Base
  attr_accessible :role, :user_id, :project_id
  belongs_to :user
  belongs_to :project

end
