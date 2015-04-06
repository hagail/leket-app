class CreateSupplierReports < ActiveRecord::Migration
  def change
    create_table :supplier_reports do |t|
      t.integer :quantity

      t.timestamps null: false
    end

    add_reference :supplier_reports, :pickup_report, index: true
    add_reference :supplier_reports, :supplier, index: true
    add_reference :supplier_reports, :container, index: true
    add_reference :supplier_reports, :food_type, index: true
  end
end
