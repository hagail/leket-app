class SupplierReport < ActiveRecord::Base
  belongs_to :pickup_report
  belongs_to :supplier
  has_many   :food_type_reports
end
