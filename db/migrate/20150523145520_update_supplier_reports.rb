class UpdateSupplierReports < ActiveRecord::Migration
  def change
    remove_reference :supplier_reports, :container, index: true
    remove_reference :supplier_reports, :food_type, index: true
  end
end
