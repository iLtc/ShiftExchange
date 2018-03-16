class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.string :start
      t.string :end
      t.string :location
      t.string :shift_type
      t.string :status

      t.timestamps
    end
  end
end
