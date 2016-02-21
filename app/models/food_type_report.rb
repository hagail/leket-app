# == Schema Information
#
# Table name: food_type_reports
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  pickup_report_id   :integer
#  food_type_id       :integer
#  supplier_report_id :integer
#

class FoodTypeReport < ActiveRecord::Base
  belongs_to :supplier_report
  belongs_to :food_type
  has_many   :container_reports

  delegate :name, to: :food_type

  def collected_any?
    container_reports.any?{ |x| x.collected_any? }
  end
end
