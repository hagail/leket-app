# == Schema Information
#
# Table name: supplier_reports
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pickup_report_id :integer
#  supplier_id      :integer
#  pickup_reason_id :integer
#

class SupplierReport < ActiveRecord::Base
  belongs_to :pickup_report
  belongs_to :supplier
  has_many   :food_type_reports, dependent: :destroy
  belongs_to :pickup_reason

  has_many :container_reports, through: :food_type_reports

  def pickup_reason_name
    pickup_reason.andand.name
  end

  def collected_any?
    container_reports.any?(&:collected_any?)
  end

  def top_supplier
    supplier.supplier_id.nil? ? supplier : supplier.supplier
  end

  def top_supplier?
   top_supplier == self
  end

  def single_supplier?
    supplier_id.nil?
  end

  def pickup_reason_by_condition!
    check_there_was_food!
    check_volunteer_didnt_go!
  end

  private

  def check_there_was_food!
    # if something was collected add to it 'there was food'
    if collected_any? && pickup_reason_id.blank?
      reason = PickupReason.where(priority_id: "01").first
      update_column(:pickup_reason_id, reason.id)
    end
  end

  def check_volunteer_didnt_go!
    # if something was collected add to it 'volunteer didnt go'
    if !collected_any? && pickup_reason_id.blank?
      reason = PickupReason.where(priority_id: "06").first
      update_column(:pickup_reason_id, reason.id)
    end
  end
end
