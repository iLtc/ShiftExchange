class CreatePermissionRoleJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions_roles, id: false do |t|
      t.belongs_to :permission, foreign_key: true
      t.belongs_to :role, foreign_key: true
    end
  end
end
