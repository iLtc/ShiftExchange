class RemoveNameFromPermissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :permissions, :name, :string
  end
end
