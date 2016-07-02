class AddPickupReasonToSupplierReport < ActiveRecord::Migration
  def change
    add_column :supplier_reports, :pickup_reason_id, :integer
  end
end
