class Project < ActiveRecord::Base
  attr_accessible :description, :name, :state
  has_many :features
  validates_presence_of :description, :name
end
