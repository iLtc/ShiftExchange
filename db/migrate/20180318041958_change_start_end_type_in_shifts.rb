class ChangeStartEndTypeInShifts < ActiveRecord::Migration[5.1]
  def change
    remove_column :shifts, :start
    remove_column :shifts, :end
    add_column :shifts, :start, :time
    add_column :shifts, :end, :time
  end
end
