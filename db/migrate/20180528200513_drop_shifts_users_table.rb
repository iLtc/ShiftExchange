class DropShiftsUsersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :shifts_users
  end
end
