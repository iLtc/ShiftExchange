class CreateShiftUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_users do |t|
      t.references :shift, foreign_key: true
      t.references :user, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
