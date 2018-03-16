class CreateLoginCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :login_credentials do |t|
      t.string :credential
      t.string :platform
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
