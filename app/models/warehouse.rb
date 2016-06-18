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
require 'csv'

class Warehouse < ActiveRecord::Base

 def name_with_address
  "#{name} - #{address}"
 end

 def self.process_from_csv(filename)
  warehouse_from_file = CSV.read(filename, col_sep: ",")[1..-1]
  warehouse_from_file.map do |warehouse_line|
   warehouse = Warehouse.create(
    priority_id: warehouse_line[0],
    name: warehouse_line[1],
    city: warehouse_line[2],
    address: warehouse_line[3]
   )
  end
 end
end
