class FoodTypeReport < ActiveRecord::Base
  belongs_to :supplier_report
  belongs_to :food_type
  has_many   :container_reports
end