class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :priority_id
      t.string :name

      t.timestamps null: false
    end
  end
end
