require 'spec_helper'

describe Supplier do
  let(:subject) { create(:supplier, :top_supplier) }
  describe '#top_supplier?' do
    it "returns true" do
      expect(subject.top_supplier?).to eq true
    end

    context "not top supplier" do
      let(:subject) { create(:supplier, :sub_supplier) }
      it "return false" do
        expect(subject.top_supplier?).to eq false
      end
    end
  end

  describe "#single_supplier?" do
    it "returns true" do
      expect(subject.single_supplier?).to eq true
    end

    context "not top supplier" do
      let(:subject) { create(:supplier, :sub_supplier) }
      it "return false" do
        expect(subject.single_supplier?).to eq false
      end
    end
  end
end
