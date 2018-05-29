class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true
      t.string :action
      t.string :target_type
      t.integer :target_id
      t.text :data

      t.timestamps
    end
  end
end
