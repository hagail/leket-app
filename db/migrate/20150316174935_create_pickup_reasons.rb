class CreatePickupReasons < ActiveRecord::Migration
  def change
    create_table :pickup_reasons do |t|
      t.string :priority_id
      t.string :name

      t.timestamps null: false
    end
  end
end
