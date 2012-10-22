class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.text :description
      t.string :state
      t.integer :priority
      t.integer :difficulty

      t.timestamps
    end
  end
end
