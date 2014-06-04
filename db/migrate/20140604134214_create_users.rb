class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.boolean :active, default: false
      t.string :activation_token

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
