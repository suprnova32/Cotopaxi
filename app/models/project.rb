class Project < ActiveRecord::Base
  attr_accessible :description, :name, :state, :state_event, :roles_attributes, :customer_ids, :stakeholder_ids, :team_member_ids
  has_many :features, dependent: :destroy
  validates_presence_of :description, :name
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  accepts_nested_attributes_for :roles

  has_many :team_member_roles, class_name: Role.name, conditions: {:role => "team_member"}
  has_many :team_members, through: :team_member_roles, source: :user

  has_many :stakeholder_roles, class_name: Role.name, conditions: {:role => "stakeholder"}
  has_many :stakeholders, through: :stakeholder_roles, source: :user

  has_many :customer_roles, class_name: Role.name, conditions: {:role => "customer"}
  has_many :customers, through: :customer_roles, source: :user

  has_one :scrum_master_role, class_name: Role.name, conditions: {role: "scrum_master"}
  has_one :scrum_master, through: :scrum_master_role, source: :user

  has_one :product_owner_role, class_name: Role.name, conditions: {role: "product_owner"}
  has_one :product_owner, through: :product_owner_role, source: :user


  SINGLE_ROLES = [:scrum_master, :product_owner]
  MANY_ROLES = [:customers, :stakeholders, :team_members]

  state_machine :state, initial: :created do
    #before_transition on:  :complete, do: :features_done?

    event :start do
      transition :created => :in_progress
    end

    event :complete do
      transition :in_progress => :done
    end
  end

  def project_ability(user)
    current_ability = Ability.new(user, self.id)
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

  def set_title_background
    status = {'created' => 'info', 'in_progress' => 'warning', 'done' => 'success'}
    status[self.state]
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
      'btn-danger prevent'
    end
  end

  def drag_available
    if self.features_done?
      "no_drag"
    else
      "feature_table"
    end
  end

  def disable_new_feature
    if self.state == 'done'
      'disabled'
    else
      'btn-primary'
    end
  end

  def assign_roles(params)
    @role_to_be = Role.find(params[:id])
    @role_to_be.update_attributes(params)
  end
end
