class AddFinishDateToSprints < ActiveRecord::Migration
  def change
    add_column :sprints, :finish_date, :timestamp
  end
end
