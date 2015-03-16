require 'spec_helper'

describe SupplierReview do
  it { should validate_uniqueness_of(:container_id)
                .scoped_to(:review_id, :supplier_id, :food_type_id) }
end