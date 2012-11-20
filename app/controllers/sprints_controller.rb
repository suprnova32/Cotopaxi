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
class SprintsController < ApplicationController

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:id])
  end

  # PUT /sprints/1
  # PUT /sprints/1.json
  def update
    @project = Project.find(params[:project_id])
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to @project, flash: {success: 'Sprint was successfully updated.' }}
        format.json { head :no_content }
      else
        format.html { redirect_to @project, flash: {error: "Sprint wasn't updated. Please try again."}}
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def past_sprints
    @project = Project.find(params[:id])
    @sprints = @project.sprints

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sprint }
    end

  end

end
