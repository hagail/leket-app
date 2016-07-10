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


require 'spec_helper'

describe PickupReason do
  before do
    PickupReason.process_from_csv("db/pickup_reasons.csv")
  end

  describe ".reasons_collection" do
    let(:collection) { PickupReason.reasons_collection }

    it "doesnt include the 'other' option" do
      expect(collection.map(&:last).flatten).not_to include "אחר"
    end

    it "structured as array of reasons" do
      expect(collection.map(&:last).flatten).to include(
        *[
          "היה אוכל",
          "לא היה אוכל",
          "איש קשר לא ענה",
          "לא התקבל משוב",
          "מתנדב לא הלך",
          "בעית תיאום - מתנדב",
          "בעית תיאום - ספק",
          "לא שובץ מתנדב"
        ]
      )
    end
  end
end
