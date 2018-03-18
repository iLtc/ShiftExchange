class AddPeriodToShifts < ActiveRecord::Migration[5.1]
  def change
    add_column :shifts, :period, :string
  end
end
