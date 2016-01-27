class PickupReportsController < ApplicationController
  prepend_before_action :authenticate_user!

  def new
    @pickup = Pickup.find(params[:pickup_id])
    @pickup_report = @pickup.pickup_report || ReportBuilder.build_pickup_report(@pickup)

    @date = @pickup.date
    @supplier_name = @pickup.supplier.name
  end

  def index
  end

  def update
    pickup = Pickup.find(params[:id])
    pickup.pickup_report.notes = pickup_params[:notes]
    pickup.pickup_report.warehouse = Warehouse.find(pickup_params[:warehouse_id])
    pickup.pickup_report.save!

    pickup_params[:supplier_report].each {|sid, sv| sv[:food_type_report].each { |fid, fv| fv[:container_report].each { |cid, cv| ContainerReport.find(cid).update_attributes(quantity: cv[:quantity]) } } }

    redirect_to thank_you_path
  end

  private

  def pickup_params
    params.require(:pickup_report)
  end
end
