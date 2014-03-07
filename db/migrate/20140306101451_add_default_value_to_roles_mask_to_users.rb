class AddDefaultValueToRolesMaskToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :roles_mask, :integer, default: 4
  end
end
