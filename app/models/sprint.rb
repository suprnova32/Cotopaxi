class Sprint < ActiveRecord::Base
  has_many :features
  belongs_to :project
  attr_accessible :duration, :project_id, :state, :state_event
  validates_presence_of :project

  state_machine :state, initial: :created do

    event :start do
      transition :created => :in_progress
    end

    event :complete do
      transition :in_progress => :done
    end

  end
end
