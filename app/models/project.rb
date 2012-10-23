class Project < ActiveRecord::Base
  attr_accessible :description, :name, :state
  has_many :features, dependent: :destroy
  validates_presence_of :description, :name

  def set_status_label
    status = {'created' => 'info', 'started' => 'inverse', 'in progress' => 'important', 'done' => 'success'}
    status[self.state]
  end
end
