# == Schema Information
#
# Table name: pickup_reasons
#
#  id             :integer          not null, primary key
#  priority_id    :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_displayed :boolean          default(FALSE)
#

require 'csv'

class PickupReason < ActiveRecord::Base
  # 01,היה אוכל
  # 02,לא היה אוכל
  # 04,אחר
  # 05,איש קשר לא ענה
  # 06,מתנדב לא הלך
  DISPLAY_TO_USER = %w(01 02 04 05 06).freeze

  scope :user_displayable, -> { where(user_displayed: true) }

  def self.process_from_csv(filename)
    reasons_from_file = CSV.read(filename, col_sep: ",")[1..-1]
    reasons_from_file.map do |reason_line|
      reason = PickupReason.new(
        priority_id: reason_line[0],
        name:        reason_line[1]
      )
      reason.user_displayed = true if DISPLAY_TO_USER.include?(reason.priority_id)
      reason.save
    end
  end
end
