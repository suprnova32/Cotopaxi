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
# along with this program.  If not, see <http://www.gnu.org/licenses/>..
class FeaturesController < ApplicationController

  load_and_authorize_resource

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:project_id])
  end
  # GET /features
  # GET /features.json
  def index
    @project = Project.find(params[:project_id])
    @features = @project.features.by_priority

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @features }
    end
  end

  # GET /features/1
  # GET /features/1.json
  def show
    @feature = Feature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feature }
    end
  end

  # GET /features/new
  # GET /features/new.json
  def new
    @feature = Feature.new
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feature }
    end
  end

  # GET /features/1/edit
  def edit
    @feature = Feature.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  # POST /features
  # POST /features.json
  def create
    @feature = Feature.new(params[:feature])
    @project = Project.find(params[:project_id])
    @feature.project = @project

    respond_to do |format|
      if @feature.save
        format.html { redirect_to project_url(@feature.project), flash: {success: 'Feature was successfully created.'}}
        format.json { render json: @feature, status: :created, location: @feature }
      else
        format.html { render action: "new" }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /features/1
  # PUT /features/1.json
  def update
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to project_url(@feature.project), flash: {success: 'Feature was successfully updated.'}}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.json
  def destroy
    @feature = Feature.find(params[:id])
    project = @feature.project
    @feature.destroy

    respond_to do |format|
      format.html { redirect_to project_url(project), flash: {success: 'Feature was successfully deleted.'} }
      format.json { head :no_content }
    end
  end
end
