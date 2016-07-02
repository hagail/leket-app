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
require 'csv'

class PickupReport < ActiveRecord::Base
  belongs_to :pickup
  belongs_to :pickup_reason
  belongs_to :warehouse
  has_many :supplier_reports, dependent: :destroy

  has_many :food_type_reports, through: :supplier_reports
  has_many :container_reports, through: :food_type_reports

  def collected_any?
    container_reports.any?(&:collected_any?)
  end

  def self.report_file_name
    "public/#{Date.today.strftime}.txt"
  end

  def self.create_approved_csv
    @reports = PickupReport.joins('LEFT JOIN supplier_reports ON supplier_reports.pickup_report_id = pickup_reports.id')
                           .joins('LEFT JOIN food_type_reports ON food_type_reports.supplier_report_id = supplier_reports.id')
                           .joins('LEFT JOIN container_reports ON container_reports.food_type_report_id = food_type_reports.id')
                           .merge(ContainerReport.approved)
                           .joins(:pickup)
                           .uniq
    # @reports = @reports.merge(Pickup.approved)


    ::CSV.open(report_file_name, 'wb',  row_sep: "\n", col_sep: "\t") do |csv|
      csv << %w(id
                date
                main_supplier
                warehouse
                pickup_reason
                subsupplier
                food_type
                container
                quantity)
      @reports.each do |pickup_report|
        # next unless pickup_report.collected_any?
        pickup = pickup_report.pickup
        pickup_report.supplier_reports.each do |supplier_report|
          supplier_report.food_type_reports.each do |food_report|
            food_report.container_reports.each do |container_report|
              next if !container_report.collected_any? || !container_report.approved?
              csv << [
                pickup.priority_id, # pickup id - pickup.priority_id
                pickup.date,                               # date - pickup.date
                supplier_report.top_supplier.priority_id,  # main supplier - supplier_report.top_supplier.priority_id
                pickup_report.warehouse.priority_id,       # warehouse id
                supplier_report.pickup_reason.priority_id, # pickup reason id -
                supplier_report.supplier.priority_id,      # subsupplier - supplier_report.supplier.priority_id
                food_report.food_type.priority_id,         # food type - food_report.food_type.priority_id
                container_report.container.priority_id,    # container - container_report.container.priority_id
                container_report.quantity                  # quantity - container_report.quantity
              ]
            end
          end
        end
      end
    end
  end
end
