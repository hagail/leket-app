class AddFoodTypeReportIdIndexToSuppliers < ActiveRecord::Migration
  def change
    add_reference :food_type_reports, :supplier_report, index: true
    remove_column :container_reports, :food_type_report_id
    add_reference :container_reports, :food_type_report, index: true
  end
end
