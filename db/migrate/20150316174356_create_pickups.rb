class CreatePickups < ActiveRecord::Migration
  def change
    create_table :pickups do |t|
      t.string :priority_id
      t.string :status
      t.datetime :date

      t.timestamps null: false
    end

    add_reference :pickups, :supplier, index: true
    add_reference :pickups, :user, index: true
  end
end
