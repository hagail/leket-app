require 'spec_helper'

describe FoodTypeReport do
  describe ".collected_any?" do
    let(:ftr) { create(:food_type_report) }

    it "returns true" do
      expect(ftr.collected_any?).to eq true
    end

    context "when all container report didn't collect" do
      let(:ftr) { create(:food_type_report, container_reports: [create(:container_report, :not_collected)]) }
      it 'returns false' do
        expect(ftr.collected_any?).to eq false
      end
    end
  end
end
