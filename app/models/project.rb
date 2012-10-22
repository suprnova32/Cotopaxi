class Project < ActiveRecord::Base
  attr_accessible :description, :name, :state
  has_many :features
end
