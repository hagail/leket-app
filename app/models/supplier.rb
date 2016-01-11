# == Schema Information
#
# Table name: suppliers
#
#  id          :integer          not null, primary key
#  priority_id :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  supplier_id :integer
#

class Supplier < ActiveRecord::Base
  has_many :suppliers
  belongs_to :supplier
end
