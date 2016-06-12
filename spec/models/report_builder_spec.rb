require 'spec_helper'

describe ReportBuilder do
  describe '.build_pickup_report' do
    it 'builds a report with one supplier report for a pickup without sub-suppliers' do
      supplier = Supplier.new
      pickup = Pickup.new(supplier: supplier)

      pickup_report = ReportBuilder.build_pickup_report(pickup)

      expect(pickup_report.supplier_reports.length).to eq 1
      expect(pickup_report.supplier_reports.first.supplier).to eq supplier
    end

    it 'builds a report with all sub-supplier report for a pickup with sub-suppliers' do
      subSupplier = Supplier.new
      supplier = Supplier.new(suppliers: [subSupplier])
      pickup = Pickup.new(supplier: supplier)

      pickup_report = ReportBuilder.build_pickup_report(pickup)

      expect(pickup_report.supplier_reports.length).to eq 1
      expect(pickup_report.supplier_reports.first.supplier).to eq subSupplier
    end
  end
end
