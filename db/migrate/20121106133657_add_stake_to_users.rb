class AddStakeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stakeholder, :boolean, default: false
  end
end
