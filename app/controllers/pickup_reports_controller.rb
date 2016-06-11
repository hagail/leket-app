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

  prepend_before_action :authenticate_user!, excepy: [:summary, :approve]
  http_basic_authenticate_with name: 'test', password: 'test', only: [:summary, :approve]

  def new
    @pickup = Pickup.find(params[:pickup_id])
    @pickup_report = @pickup.pickup_report || ReportBuilder.build_pickup_report(@pickup)

    @date = @pickup.date
    @supplier_name = @pickup.supplier.name
  end

  def index
  end

  def update
    report = PickupReport.find(params[:id])
    report.notes = pickup_params[:notes]
    report.warehouse = Warehouse.find(pickup_params[:warehouse_id])
    report.save!

    report.update_attributes(pickup_report_params)

    pickup_params[:supplier_report].each do |sid, sv|
      sv[:food_type_report].each do |fid, fv|
        fv[:container_report].each do |cid, cv|
          ContainerReport.find(cid).update_attributes(quantity: cv[:quantity])
        end
      end
    end

    redirect_to thank_you_path

  end
  #
  # def summary
  #   # need pickup report with supplier report with food type and container report for each user
  #
  #   approved = params[:approved] == "yes" ? true : false
  #
  #   @reports = PickupReport.includes(supplier_reports: :supplier, food_type_reports: :food_type, container_reports: :container ).joins(:pickup).uniq
  #
  #   if approved
  #     @reports = @reports.merge(Pickup.approved)
  #   else
  #     @reports = @reports.merge(Pickup.not_approved)
  #   end
  #
  # end
  #
  # def approve
  #
  #   report = PickupReport.find(params[:id])
  #
  #   pickup = report.pickup
  #
  #   pickup.approve!
  #
  #   head :ok
  # end
  #
  # def unapprove
  #   report = PickupReport.find(params[:id])
  #
  #   pickup = report.pickup
  #
  #   pickup.unapprove!
  #
  #   head :ok
  # end

  private

  def pickup_params
    params.require(:pickup_report)
  end

  def pickup_report_params
    pickup_params.permit(:notes, :id)
  end

end
