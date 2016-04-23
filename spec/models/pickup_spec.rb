require 'spec_helper'

describe Pickup do
  let(:approved_at) { nil }
  let(:sent_at) { nil }
  let(:pickup) do
    Pickup.create(priority_id: 10,
                  status: 'status',
                  approved_at: approved_at,
                  sent_at: sent_at)
  end

  describe '.approved?' do
    let(:approved_at) { Time.now }

    it 'returns true if approved is filled' do
      expect(pickup.approved?).to be_truthy
    end
  end

  describe '.approve!' do
    it 'marks pickups as approved' do
      pickup.approve!

      expect(pickup.approved?).to be_truthy
    end
  end

  describe '.sent?' do
    let(:sent_at) { Time.now }

    it 'returns true if pickup was sent' do
      expect(pickup.sent?).to be_truthy
    end
  end
end
