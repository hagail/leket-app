# == Schema Information
#
# Table name: containers
#
#  id           :integer          not null, primary key
#  priority_id  :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  food_type_id :integer
#

class Container < ActiveRecord::Base
end
