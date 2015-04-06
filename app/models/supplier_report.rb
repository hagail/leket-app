class SupplierReport < ActiveRecord::Base
  validates :container_id, :uniqueness => {:scope => [:pickup_report_id, :supplier_id, :food_type_id]}

  belongs_to :pickup_report
  belongs_to :supplier
  belongs_to :food_type
  belongs_to :container
end
