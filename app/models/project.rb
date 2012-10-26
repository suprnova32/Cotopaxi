class Project < ActiveRecord::Base
  attr_accessible :description, :name, :state, :state_event
  has_many :features, dependent: :destroy
  validates_presence_of :description, :name

  state_machine :state, initial: :created do
    before_transition on:  :complete, do: :features_done?

    event :start do
      transition :created => :in_progress
    end

    event :complete do
      transition :in_progress => :done
    end
  end

  def features_done?
    counter = 0
    self.features.each do |feature|
      if feature.state == 'done'
          counter += 1
      end
    end
    if counter == features.length
      true
    else
      false
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
    status = {'created' => 'btn-success','in_progress' => self.complete_button, 'done' => 'disabled'}
    status[self.state]
  end

  def set_status_label
    status = {'created' => 'info', 'in_progress' => 'important', 'done' => 'success'}
    status[self.state]
  end

  def complete_button
    if self.features_done?
      'btn-success'
    else
      'disabled'
    end
  end

  def drag_available
    if self.features_done?
      "no_drag"
    else
      "feature_table"
    end
  end
end
