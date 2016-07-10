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

require 'spec_helper'

describe Pickup do
  let(:approved_at) { nil }
  let(:sent_at) { nil }
  let(:pickup) do
    Pickup.create(priority_id: 10,
                  status:      'status',
                  approved_at: approved_at,
                  sent_at:     sent_at)
  end

  describe '#approved?' do
    let(:approved_at) { Time.now }

    it 'returns true if approved is filled' do
      expect(pickup.approved?).to be_truthy
    end
  end

  describe '#approve!' do
    it 'marks pickups as approved' do
      pickup.approve!

      expect(pickup.approved?).to be_truthy
    end
  end

  describe "#unapprove!" do
    let(:approved_at) { Time.now }
    it "sets approved_at to nil" do
      pickup.unapprove!

      expect(pickup.approved_at).to be nil
    end
  end

  describe '#sent?' do
    let(:sent_at) { Time.now }

    it 'returns true if pickup was sent' do
      expect(pickup.sent?).to be_truthy
    end
  end

  describe "#sent!" do
    it "sets the sent_at to the current time" do
      Timecop.freeze

      pickup.sent!

      expect(pickup.sent_at).to eq Time.now
    end
  end
end
