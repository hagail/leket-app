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

module ContainerReportsHelper
end
