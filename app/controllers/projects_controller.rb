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
class ProjectsController < ApplicationController

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:id])
  end

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @features = @project.features.by_priority
    @users = User.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    authorize! :create, Project
    @project = Project.new
    #authorize! :create, @project

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    authorize! :edit, Project
    @project = Project.find(params[:id])
    @users = User.all
  end

  # POST /projects
  # POST /projects.json
  def create
    authorize! :create, Project
    @project = Project.new(params[:project])
    @project.roles << Role.new(role: :product_owner, project_id: @project.id)
    @project.roles << Role.new(role: :scrum_master, project_id: @project.id)
    @project.stakeholder_ids = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, flash: {success: 'Project was successfully created.'}}
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    authorize! :update, Project
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, flash: {success: 'Project was successfully updated.'}}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    authorize! :destroy, Project
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, flash: {success: 'Project was successfully deleted.'} }
      format.json { head :no_content }
    end
  end

  def sort_features
    authorize! :prioritize_feature, Project
    @project = Project.find(params[:id])
    @order = params[:order]
    @index = 1
    @order.each do |order|
      feature = @project.features.find(order)
      feature.priority = @index
      feature.save!
      @index += 1
    end
    respond_to do |format|
      format.json { render json: @order }
    end

  end

  def assign_roles
    new_params = params[:role]
    authorize! :assign_roles, Project
    @project = Project.find(params[:id])
    @project.assign_roles(new_params)
    respond_to do |format|
      format.html { redirect_to project_url(@project), flash: {success: 'Project was successfully updated.'} }
      format.json { render json: @project }
    end

  end

  def plan_sprint
    @project = Project.find(params[:id])
    if @project.sprints == []
      @sprint = Sprint.new
      @sprint.duration = @project.sprint_duration
      @sprint.project = @project
      @sprint.save!
    elsif @project.sprints.last.state == 'done'
      index = @project.sprints.last.number
      index += 1
      @sprint = Sprint.new
      @sprint.duration = @project.sprint_duration
      @sprint.project = @project
      @sprint.number = index
      @sprint.save!
    else
      @sprint = @project.sprints.last
    end

    respond_to do |format|
      format.html
    end
  end

  def confirm_sprint
    @feature = Feature.find(params[:feature_id])
    if params[:sprint_id] != "0"
      @sprint = Sprint.find(params[:sprint_id])
      @feature.sprint = @sprint
    else
      @feature.sprint = nil
    end

    respond_to do |format|
      if @feature.save
        format.json {render json: @sprint}
      else
        format.json {render json: @sprint.errors, status: :unprocessable_entity}
      end

    end
  end
end
