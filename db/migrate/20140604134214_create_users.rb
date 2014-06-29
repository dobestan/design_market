class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :dcoin, default: 0

      t.string :remember_token

      t.boolean :active, default: false
      t.string :activation_token

      t.boolean :admin, default: false
      t.boolean :designer, default: false
      t.boolean :client, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
