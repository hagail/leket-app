# == Schema Information
#
# Table name: warehouses
#
#  id          :integer          not null, primary key
#  priority_id :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Warehouse < ActiveRecord::Base
end
