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

  scope :approved, ->{ where("pickups.approved_at IS NOT NULL")}
  scope :not_approved, ->{ where("pickups.approved_at IS NULL")}

  def approved?
    !approved_at.nil?
  end

  def approve!
    self.update_column(:approved_at, Time.now)
  end

  def unapprove!
    self.update_column(:approved_at, nil)
  end

  def sent?
    !sent_at.nil?
  end

  def sent!
    self.update_column(:sent_at, Time.now)
  end
end
