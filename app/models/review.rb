class Review < ActiveRecord::Base
  belongs_to :pickup
  has_one :pickup_reason
  has_one :warehouse
end
