# == Schema Information
#
# Table name: warehouses
#
#  id          :integer          not null, primary key
#  priority_id :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city        :string
#  address     :string
#

require 'spec_helper'

describe Warehouse do
  describe "#name_with_address" do
    it "returns the name with address" do
      warehouse = create(:warehouse, name: "test", address: "some street")

      expect(warehouse.name_with_address).to eq "test - some street"
    end
  end
end
