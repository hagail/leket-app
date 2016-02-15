# == Schema Information
#
# Table name: supplier_reports
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pickup_report_id :integer
#  supplier_id      :integer
#

class SupplierReport < ActiveRecord::Base
  belongs_to :pickup_report
  belongs_to :supplier
  has_many   :food_type_reports

  has_many :container_reports, through: :food_type_reports

  def collected_any?
    container_reports.any?{|x| x.collected_any?}
  end

  def top_supplier
    supplier.supplier_id.nil? ? supplier : supplier.supplier
  end

end
