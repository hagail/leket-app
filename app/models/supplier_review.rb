class SupplierReview < ActiveRecord::Base
  validates :container_id, :uniqueness => {:scope => [:review_id, :supplier_id, :food_type_id]}
end
