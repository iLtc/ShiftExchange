class CreateKeyValues < ActiveRecord::Migration[5.1]
  def change
    create_table :key_values do |t|
      t.string :key
      t.string :key_type
      t.string :value
      t.text :description

      t.timestamps
    end
  end
end
