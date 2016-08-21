# == Schema Information
#
# Table name: supplier_reports
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pickup_report_id :integer
#  supplier_id      :integer
#  pickup_reason_id :integer
#

require 'spec_helper'

describe SupplierReport do
  let(:sr) { SupplierReport.create }

  describe "#pickup_reason_name" do
    let(:reason) { double(:reason, name: "my reason") }
    before do
      allow(sr).to receive(:pickup_reason).and_return reason
    end

    it "delegates the method to pickup reason" do
      expect(sr.pickup_reason_name).to eq reason.name
    end
  end

  describe "#collected_any?" do
    before do
      allow(sr).to receive(:container_reports).and_return container_reports
    end

    context "container_reports collected" do
      let(:container_reports) do
        [
          double(:cr, collected_any?: false),
          double(:cr, collected_any?: false),
          double(:cr, collected_any?: true)
        ]
      end

      it "returns true" do
        expect(sr.collected_any?).to eq true
      end
    end

    context "container_reports didn't collect" do
      let(:container_reports) do
        [
          double(:cr, collected_any?: false),
          double(:cr, collected_any?: false),
          double(:cr, collected_any?: false)
        ]
      end

      it "returns false" do
        expect(sr.collected_any?).to eq false
      end
    end
  end

  describe "#top_supplier" do
    before do
      allow(sr).to receive(:supplier).and_return supplier
    end

    context "supplier has no supplier" do
      let(:supplier) { double(:supplier, supplier_id: nil) }
      it "return the supplier" do
        expect(sr.top_supplier).to eq supplier
      end
    end

    context "supplier has a parent supplier" do
      let(:supplier) { double(:supplier, supplier_id: 5, supplier: "TopSupp") }
      it "returns the parent supplier" do
        expect(sr.top_supplier).to eq "TopSupp"
      end
    end
  end

  describe "#top_supplier?" do
    context "supplier has no supplier" do
      let(:supplier) { create(:supplier, supplier_id: nil) }
      it "return the supplier" do
        expect(supplier.top_supplier?).to eq true
      end
    end

    context "supplier has a parent supplier" do
      let(:supplier) { create(:supplier, supplier_id: 5) }
      it "returns the parent supplier" do
        expect(supplier.top_supplier?).to eq false
      end
    end
  end

  describe "#pickup_reason_by_condition!" do
    context "there was a collection of food with no reason" do
      let!(:reason_food) { PickupReason.create(priority_id: "01") }

      before do
        allow(sr).to receive(:collected_any?).and_return true
        allow(sr).to receive(:pickup_reason_id).and_return ""
        allow(sr).to receive(:pickup_reason_id).and_call_original
      end

      it "sets the reason id as the id of 'there was food' reason" do
        sr.pickup_reason_by_condition!

        expect(sr.pickup_reason_id).to eq reason_food.id
      end
    end

    context "volunteer didn't go" do
      let!(:reason_didnt_go) { PickupReason.create(priority_id: "06") }

      before do
        allow(sr).to receive(:collected_any?).and_return false
        allow(sr).to receive(:pickup_reason_id).and_return ""
        allow(sr).to receive(:pickup_reason_id).and_call_original
      end

      it "sets the reason id as the id of 'didnt go' reason" do
        sr.pickup_reason_by_condition!

        expect(sr.pickup_reason_id).to eq reason_didnt_go.id
      end
    end
  end
end
