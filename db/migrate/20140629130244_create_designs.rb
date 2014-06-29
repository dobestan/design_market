class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.references :user
      t.references :request

      t.timestamps
    end
  end
end
