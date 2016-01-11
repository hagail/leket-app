# == Schema Information
#
# Table name: pickup_reports
#
#  id               :integer          not null, primary key
#  food_picked_up   :boolean
#  notes            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pickup_id        :integer
#  warehouse_id     :integer
#  pickup_reason_id :integer
#

class PickupReport < ActiveRecord::Base
  belongs_to :pickup
  belongs_to :pickup_reason
  belongs_to :warehouse
  has_many :supplier_reports

  has_many :food_type_reports, through: :supplier_reports
  has_many :container_reports, through: :food_type_reports

  def collected_any?
    container_reports.any?{|x| x.collected_any? }
  end
end
