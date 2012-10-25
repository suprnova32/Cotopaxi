class Project < ActiveRecord::Base
  attr_accessible :description, :name, :state, :state_event
  has_many :features, dependent: :destroy
  validates_presence_of :description, :name

  state_machine :state, initial: :created do
    #after_transition on:  :start, do: :feature_started

    event :start do
      transition :created => :in_progress
    end

    event :complete do
      transition :in_progress => :done
    end

    event :done do

    end

  end

  def set_state_change_button
    status = {'created' => 'Start!', 'in_progress' => 'Complete!', 'done' => 'Done!'}
    status[self.state]
  end

  def set_state_transition
    trans = {'created' => :start, 'in_progress' => :complete, 'done' => :done}
    trans[self.state]
  end

  def set_disabled_button
    status = {'created' => 'btn-success','in_progress' => 'btn-success', 'done' => 'disabled'}
    status[self.state]
  end

  def set_status_label
    status = {'created' => 'info', 'in_progress' => 'important', 'done' => 'success'}
    status[self.state]
  end
end
