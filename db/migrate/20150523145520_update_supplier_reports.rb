class UpdateSupplierReports < ActiveRecord::Migration
  def change
    remove_reference :supplier_reports, :container
    remove_reference :supplier_reports, :food_type
    remove_column    :supplier_reports, :quantity
  end
end
