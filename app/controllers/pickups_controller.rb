# == Schema Information
#
# Table name: pickups
#
#  id          :integer          not null, primary key
#  priority_id :string
#  status      :string
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  supplier_id :integer
#  user_id     :integer
#  approved_at :datetime
#  sent_at     :datetime
#

class PickupsController < ApplicationController
  prepend_before_action :authenticate_user!

  def index
    @user = current_user
    @pickup_reasons = PickupReason.user_displayable
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
