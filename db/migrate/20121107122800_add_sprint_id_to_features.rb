class AddSprintIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :sprint_id, :integer
  end
end
