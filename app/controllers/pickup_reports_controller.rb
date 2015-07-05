class PickupReportsController < ApplicationController
  def new
    @pickup = Pickup.find(params[:pickup_id])
    @pickup_report = @pickup.pickup_report || ReportBuilder.build_pickup_report(@pickup)
  end
end
