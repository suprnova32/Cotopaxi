class Feature < ActiveRecord::Base
  attr_accessible :description, :name, :state, :difficulty, :priority
  belongs_to :project
end
