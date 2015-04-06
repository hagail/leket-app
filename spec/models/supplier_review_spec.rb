require 'spec_helper'

describe SupplierReport do
  it { should validate_uniqueness_of(:container_id)
                .scoped_to(:pickup_report_id, :supplier_id, :food_type_id) }
end