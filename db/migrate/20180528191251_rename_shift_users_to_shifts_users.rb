class RenameShiftUsersToShiftsUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :shift_users, :shifts_users
  end
end
