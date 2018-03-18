class ChangeStartEndTypeInShifts < ActiveRecord::Migration[5.1]
  def change
    remove_column :shifts, :start, :string
    remove_column :shifts, :end, :string
    add_column :shifts, :start, :time
    add_column :shifts, :end, :time
  end
end
