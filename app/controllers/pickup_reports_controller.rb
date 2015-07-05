class PickupReportsController < ApplicationController
  def new
    @current_pickup = Pickup.find(params[:pickup_id])
    @pickup_report = current_pickup.pickup_report || ReportBuilder.build_pickup_report(current_pickup)
  end
end
