class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :duration
      t.integer :project_id, null: false
      t.integer :number, default: 1
      t.string  :state, default: "created"

      t.timestamps
    end
  end
end
