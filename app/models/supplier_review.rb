class SupplierReview < ActiveRecord::Base
  validates :container_id, :uniqueness => {:scope => [:review_id, :supplier_id, :food_type_id]}

  belongs_to :review
  belongs_to :supplier
  belongs_to :food_type
  belongs_to :container
end
