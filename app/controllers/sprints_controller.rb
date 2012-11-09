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
