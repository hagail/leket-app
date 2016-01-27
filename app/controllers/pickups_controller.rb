class PickupsController < ApplicationController
  def index
    # current_user by email :)
    @user = User.first
    @pickup_reasons = PickupReason.all
  end

  def mark_as_not_picked
    pickup = Pickup.find(params.require(:pickup_id))

    pickup_report = PickupReport.new(pickup: pickup)
    pickup_report.pickup_reason = PickupReason.find(params.require(:reason_id))
    pickup_report.save!

    redirect_to pickups_path
  end

  def thank_you
    render layout: false
  end
end
