class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :state, default: "created"

      t.timestamps
    end
  end
end
