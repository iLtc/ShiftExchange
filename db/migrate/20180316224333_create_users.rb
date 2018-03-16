class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :prefer_name
      t.integer :credits, :default => 0
      t.integer :level, :default => 0

      t.timestamps
    end
  end
end
