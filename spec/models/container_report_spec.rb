require 'spec_helper'

describe ContainerReport do
  let(:quantity) { 7 }
  let(:cr) { create(:container_report, quantity: quantity) }

  describe "#collected_any?" do
    specify { expect(cr.collected_any?).to eq true }
    context "quantity is 0" do
      let(:quantity) { 0 }
      specify { expect(cr.collected_any?).to eq false }
    end
  end

  describe "#approved?" do
    context "approved" do
      let(:cr) { create(:container_report, :approved, quantity: quantity) }

      specify { expect(cr.approved?).to eq true }
    end

    context "not approved" do
      specify { expect(cr.approved?).to eq false }
    end
  end

  describe "#approve!" do
    it "sets the approved_at attribute" do
      cr.approve!
      expect(cr.approved_at).not_to be_nil
    end
  end

  describe "#unapprove!" do
    it "sets the approved_at to nil" do
      cr.unapprove!
      expect(cr.approved_at).to be_nil
    end
  end
end
