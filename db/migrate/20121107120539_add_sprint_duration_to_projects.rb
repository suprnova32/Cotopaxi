class AddSprintDurationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :sprint_duration, :integer, default: 604800
  end
end
