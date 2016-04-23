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
#

class ContainerReport < ActiveRecord::Base
  belongs_to :container
  belongs_to :food_type_report

  scope :used, -> { where('container_reports.quantity > 0') }

  def collected_any?
    quantity > 0
  end
end
