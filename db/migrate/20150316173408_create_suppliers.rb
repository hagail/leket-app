class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :priority_id
      t.string :name

      t.timestamps null: false
    end
    add_reference :suppliers, :supplier, index: true
  end
end
