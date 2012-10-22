class Feature < ActiveRecord::Base
  attr_accessible :description, :name, :state, :difficulty, :priority
  belongs_to :project
  validates_presence_of :project, :name, :description
end
