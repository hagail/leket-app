class PickupReport < ActiveRecord::Base
  belongs_to :pickup
  belongs_to :pickup_reason
  belongs_to :warehouse
  has_many :supplier_reports
end
