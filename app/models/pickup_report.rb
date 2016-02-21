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

  def self.approved_csv

    @reports = PickupReport.includes(supplier_reports: :supplier, food_type_reports: :food_type, container_reports: :container ).joins(:pickup).uniq
    @reports = @reports.merge(Pickup.approved)

    # pickup.priority_id
    # pickup.date
    # pickup_report.warehouse.priority_id
    # pickup_report.pickup_reason.priority_id
    # pickup_report.suppliers do
    #   supplier.food_type_reports do
    #     supplier.priority_id
    #     food_type_report.container_report
    #       food_type_report.food_type.priority_id
    #       container_report.quantity
    #       container_report.priority_id
    #     end
    #   end
    # end


    CSV.generate(col_sep: "\t") do |csv|
      csv << ["pickup.id",
              "pickup.date",
              "main_supplier.id",
              "warehouse.id",
              "pickup_reason.id",
              "subsupplier.id",
              "food_type.id",
              "container.id",
              "container.quantity"
            ]
      @reports.each do |pickup_report|
        # next unless pickup_report.collected_any?
        pickup = pickup_report.pickup
        pickup_report.supplier_reports.each do |supplier_report|
          next unless supplier_report.collected_any?
          supplier_report.food_type_reports.each do |food_report|
            food_report.container_reports.each do |container_report|
              next unless container_report.collected_any?
              csv << [pickup.priority_id,
                      pickup.date,
                      supplier_report.top_supplier.priority_id,
                      "7800230",
                       "5",
                      supplier_report.supplier.priority_id,
                      food_report.food_type.priority_id,
                      container_report.container.priority_id,
                      container_report.quantity
                      ]
            end
          end
        end
      end
    end
  end

end
