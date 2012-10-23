class Feature < ActiveRecord::Base
  attr_accessible :description, :name, :state, :difficulty, :priority
  belongs_to :project
  validates_presence_of :project, :name, :description
  scope :by_priority, order('priority asc')

  def get_difficulty
    dif = {1 => 'Very easy', 2 => 'Easy', 4 => 'Medium', 5 => 'Hard', 7 => 'Really Hard', 8 => 'Almost Impossible'}
    dif[self.difficulty] + " (#{self.difficulty})"
  end
  
  def get_priority
    prio = {1 => 'Very Important', 2 => 'Important', 3 => 'Somewhat Important', 4 => 'Normal', 5 => 'Nice to have'}
    prio[self.priority] + " (#{self.priority})"
  end

  def set_status_label
    status = {'created' => 'info', 'started' => 'inverse', 'in progress' => 'important', 'done' => 'success'}
    status[self.state]
  end

end
