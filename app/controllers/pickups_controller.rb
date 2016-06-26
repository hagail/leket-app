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
    @pickup_reasons = PickupReason.user_displayable_without_other
  end

  def mark_as_not_picked
    pr = PickupReport.find(params.require(:pickup_id))
    sr = pr.supplier_reports.find(params.require(:sr_id))
    sr.pickup_reason = PickupReason.find(params.require(:reason_id))
    sr.save!

    render json: { reason: sr.pickup_reason.name, sr_id: sr.id }
  end

  def sr_reset_picked
   pr = PickupReport.find(params.require(:pickup_id))
   sr = pr.supplier_reports.find(params.require(:sr_id))
   sr.pickup_reason = nil
   sr.save!

   head :ok
  end

  def thank_you
    render layout: false
  end
end
