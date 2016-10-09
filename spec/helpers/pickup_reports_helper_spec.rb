require 'spec_helper'

describe PickupReportsHelper do
  describe ".export_collected_report" do
    let(:pickup_report) do
      double(:pr, warehouse: double(priority_id: "warehouse_pid"),
                  pickup:    double(:pickup, priority_id: "pid", date: "today"))
    end
    let(:supplier_report) do
      double(:sr, pickup_reason: double(priority_id: "reason_pid"),
                  supplier:      double(priority_id: "stam_sup_pid"),
                  top_supplier:  double(:ts, priority_id: "top_pid"))
    end
    let(:food_report) do
      double(:fr, food_type: double(priority_id: "ft_pid"))
    end
    let(:container_report) do
      double(:cr, quantity:  3,
                  container: double(priority_id: "container_pid"))
    end

    let(:expected_line) do
      [
        "pid",
        "today",
        "top_pid",
        "warehouse_pid",
        "reason_pid",
        "stam_sup_pid",
        "ft_pid",
        "container_pid",
        3
      ]
    end

    it "return an array of attributes" do
      line = PickupReportsHelper.export_collected_report(pickup_report, supplier_report, food_report, container_report)

      expect(line).to eq expected_line
    end
  end

  describe ".export_not_collected_report" do
    let(:pickup) do
      double(:pickup, priority_id: "pid", date: "today")
    end
    let(:supplier_report) do
      double(:sr, pickup_reason: double(priority_id: "reason_pid"),
                  top_supplier:  double(:ts, priority_id: "top_pid"))
    end

    let(:expected_line) do
      [
        "pid",
        "today",
        "top_pid",
        "X",
        "reason_pid"
      ]
    end

    it "return an array of attributes" do
      line = PickupReportsHelper.export_not_collected_report(pickup, supplier_report)

      expect(line).to eq expected_line
    end
  end
end
