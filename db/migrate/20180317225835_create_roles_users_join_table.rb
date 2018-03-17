class CreateRolesUsersJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :roles_users, id: false do |t|
      t.belongs_to :role, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end
  end
end
