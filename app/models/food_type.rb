# == Schema Information
#
# Table name: food_types
#
#  id          :integer          not null, primary key
#  priority_id :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#

class FoodType < ActiveRecord::Base
  has_many :containers
end
