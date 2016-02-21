# == Schema Information
#
# Table name: pickup_reasons
#
#  id          :integer          not null, primary key
#  priority_id :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PickupReason < ActiveRecord::Base
end
