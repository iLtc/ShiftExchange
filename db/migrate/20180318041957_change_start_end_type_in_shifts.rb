class ChangeStartEndTypeInShifts < ActiveRecord::Migration[5.1]
  def change
    change_column :shifts, :start, :time
    change_column :shifts, :end, :time
  end
end
