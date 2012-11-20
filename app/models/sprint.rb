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
