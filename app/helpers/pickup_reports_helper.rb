# == Schema Information
#
# Table name: pickup_reports
#
#  id               :integer          not null, primary key
#  food_picked_up   :boolean
#  notes            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pickup_id        :integer
#  warehouse_id     :integer
#  pickup_reason_id :integer
#

module PickupReportsHelper
  module_function

 def export_collected_report(pickup_report, supplier_report, food_report, container_report)
   [
     pickup_report.pickup.priority_id,          # pickup id - pickup.priority_id
     pickup_report.pickup.date,                 # date - pickup.date
     supplier_report.top_supplier.priority_id,  # main supplier - supplier_report.top_supplier.priority_id
     pickup_report.warehouse.priority_id,       # warehouse id
     supplier_report.pickup_reason.priority_id, # pickup reason id -
     supplier_report.supplier.priority_id,      # subsupplier - supplier_report.supplier.priority_id
     food_report.food_type.priority_id,         # food type - food_report.food_type.priority_id
     container_report.container.priority_id,    # container - container_report.container.priority_id
     container_report.quantity                  # quantity - container_report.quantity
   ]
 end

 def export_not_collected_report(pickup, supplier_report)
   [
     pickup.priority_id,                        # pickup id - pickup.priority_id
     pickup.date,                               # date - pickup.date
     supplier_report.top_supplier.priority_id,  # main supplier - supplier_report.top_supplier.priority_id
     "X",       # warehouse id
     supplier_report.pickup_reason.priority_id, # pickup reason id -
   ]
 end
end
