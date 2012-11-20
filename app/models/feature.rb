# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  Patricio Cano
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
class Feature < ActiveRecord::Base
  attr_accessible :description, :name, :state, :difficulty, :priority, :state_event
  belongs_to :project
  belongs_to :sprint
  validates_presence_of :project, :name, :description
  scope :by_priority, order('priority asc')

  before_create :set_priority

  state_machine :state, initial: :created do
    after_transition on:  :start, do: :start_project

    event :start do
      transition :created => :in_progress
    end

    #event :assign do
      #transition :started => :in_progress
    #end

    event :complete do
      transition :in_progress => :done
    end
  end

  def get_difficulty
    dif = {1 => 'Very easy', 2 => 'Easy', 3 => 'Medium', 4 => 'Hard', 5 => 'Really Hard', 6 => 'Almost Impossible'}
    dif[self.difficulty] + " (#{self.difficulty})"
  end

  def set_status_label
    status = {'created' => 'info', 'started' => 'inverse', 'in_progress' => 'important', 'done' => 'success'}
    status[self.state]
  end

  def set_priority
    if self.project.features.by_priority.last
      self.priority = self.project.features.by_priority.last.priority
      self.priority += 1
    else
      self.priority = 1
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
    if self.project.state == 'done'
      'disabled'
    else
      status = {'created' => 'btn-success', 'started' => 'btn-info', 'in_progress' => 'btn-success', 'done' => 'disabled'}
      status[self.state]
    end
  end

  def start_project
    if self.project.state == 'created'
      self.project.state = 'in_progress'
      self.project.save!
    end
  end



end
