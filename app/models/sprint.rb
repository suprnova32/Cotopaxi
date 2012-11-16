class Sprint < ActiveRecord::Base
  has_many :features
  belongs_to :project
  attr_accessible :duration, :project_id, :state, :state_event, :project
  validates_presence_of :project

  state_machine :state, initial: :created do
    after_transition on:  :start, do: :set_finish_date

    event :start do
      transition :created => :in_progress
    end

    event :complete do
      transition :in_progress => :done
    end

  end

  def set_status_label
    status = {'created' => 'info', 'started' => 'inverse', 'in_progress' => 'important', 'done' => 'success'}
    status[self.state]
  end

  def set_state_change_button
    status = {'created' => 'Begin Sprint!', 'in_progress' => 'Finish Sprint', 'done' => 'Done!'}
    status[self.state]
  end

  def set_state_transition
    trans = {'created' => :start, 'in_progress' => :complete, 'done' => :done}
    trans[self.state]
  end

  def set_finish_date
    self.finish_date = self.created_at + self.duration
    self.save!
  end
end
