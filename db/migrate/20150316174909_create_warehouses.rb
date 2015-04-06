class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :priority_id
      t.string :name

      t.timestamps null: false
    end
  end
end
