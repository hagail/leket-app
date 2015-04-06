class CreatePickupReports < ActiveRecord::Migration
  def change
    create_table :pickup_reports do |t|
      t.boolean :food_picked_up
      t.string :notes

      t.timestamps null: false
    end

    add_reference :pickup_reports, :pickup, index: true
    add_reference :pickup_reports, :warehouse, index: true
    add_reference :pickup_reports, :pickup_reason, index: true
  end
end
