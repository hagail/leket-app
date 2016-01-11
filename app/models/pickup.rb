# == Schema Information
#
# Table name: pickups
#
#  id          :integer          not null, primary key
#  priority_id :string
#  status      :string
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  supplier_id :integer
#  user_id     :integer
#  approved_at :datetime
#  sent_at     :datetime
#

class Pickup < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :user
  has_one :pickup_report
  alias_attribute :report, :pickup_report

  def approved?
    !approved_at.nil?
  end

  def sent?
    !sent_at.nil?
  end
end
