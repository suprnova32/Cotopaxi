class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :state, default: "created"
      t.integer :priority
      t.integer :difficulty
      t.integer :project_id, null: false

      t.timestamps
    end
    add_index :features, :project_id
  end
end
