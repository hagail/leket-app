# == Schema Information
#
# Table name: container_reports
#
#  id                  :integer          not null, primary key
#  quantity            :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  container_id        :integer
#  food_type_report_id :integer
#  approved_at         :datetime
#

class ContainerReport < ActiveRecord::Base
  belongs_to :container
  belongs_to :food_type_report

  scope :used, -> { where('container_reports.quantity > 0') }
  scope :approved, -> { where('container_reports.approved_at IS NOT NULL') }

  def collected_any?
    quantity > 0
  end

  def approved?
    !approved_at.nil?
  end

  def approve!
    update_column(:approved_at, Time.now)
  end

  def unapprove!
    update_column(:approved_at, nil)
  end
end
