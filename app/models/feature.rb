class Feature < ActiveRecord::Base
  attr_accessible :description, :name, :state, :difficulty, :priority, :state_event
  belongs_to :project
  validates_presence_of :project, :name, :description
  scope :by_priority, order('priority asc')

  before_create :set_priority

  state_machine :state, initial: :created do
    #after_transition on:  :start, do: :feature_started

    event :start do
      transition :created => :started
    end

    event :assign do
      transition :started => :in_progress
    end

    event :complete do
      transition :in_progress => :done
    end

    event :done do

    end

  end

  def get_difficulty
    dif = {1 => 'Very easy', 2 => 'Easy', 3 => 'Medium', 4 => 'Hard', 5 => 'Really Hard', 6 => 'Almost Impossible'}
    dif[self.difficulty] + " (#{self.difficulty})"
  end
  
  def get_priority
    prio = {1 => 'Very Important', 2 => 'Important', 3 => 'Somewhat Important', 4 => 'Normal', 5 => 'Nice to have'}
    prio[self.priority] + " (#{self.priority})"
  end

  def set_status_label
    status = {'created' => 'info', 'started' => 'inverse', 'in_progress' => 'important', 'done' => 'success'}
    status[self.state]
  end

  def set_priority
    self.priority = self.project.features.by_priority.last.priority
    self.priority += 1
  end

  def set_state_change_button
    status = {'created' => 'Start!', 'started' => 'Assign!', 'in_progress' => 'Complete!', 'done' => 'Done!'}
    status[self.state]
  end

  def set_state_transition
    trans = {'created' => :start, 'started' => :assign, 'in_progress' => :complete, 'done' => :done}
    trans[self.state]
  end

  def set_disabled_button
    status = {'created' => 'btn-success', 'started' => 'btn-info', 'in_progress' => 'btn-success', 'done' => 'disabled'}
    status[self.state]
  end



end
