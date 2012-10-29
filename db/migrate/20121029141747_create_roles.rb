class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :role

      t.timestamps
    end
    add_index :roles, :user_id
    add_index :roles, :project_id
  end
end
