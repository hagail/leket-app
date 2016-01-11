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

class PickupReportsController < ApplicationController
  def new
    @pickup = Pickup.find(params[:pickup_id])
    @pickup_report = @pickup.pickup_report || ReportBuilder.build_pickup_report(@pickup)

    @date = @pickup.date
    @supplier_name = @pickup.supplier.name
  end

  def index
    # current_user by email :)
    @user = User.last
  end

  def update
    #pickup_params[:notes]

    pickup_params[:supplier_report].each {|sid, sv| sv[:food_type_report].each { |fid, fv| fv[:container_report].each { |cid, cv| ContainerReport.find(cid).update_attributes(quantity: cv[:quantity]) } } }
    render :thank_you, layout: nil
  end

  def summary
    # need pickup report with supplier report with food type and container report for each user

    @reports = PickupReport.includes(:pickup, supplier_reports: :supplier, food_type_reports: :food_type, container_reports: :container ).uniq

    # @reports = PickupReport.joins("LEFT OUTER JOIN supplier_reports ON pickup_reports.id = supplier_reports.pickup_report_id")
    # .joins("LEFT OUTER JOIN food_type_reports ON supplier_reports.id = food_type_reports.supplier_report_id")
    # .joins("LEFT OUTER JOIN container_reports ON food_type_reports.id = container_reports.food_type_report_id")
    # .distinct("pickup_reports.id")

  end

  private

  def pickup_params
    params.require(:pickup_report)
  end

end
