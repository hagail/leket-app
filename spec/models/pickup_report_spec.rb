require 'spec_helper'

describe PickupReport do
  describe "#collected_any?" do
    let(:pr) { FactoryGirl.create(:pickup_report) }
    let(:container_reports) { [] }
    before do
      allow(pr).to receive(:container_reports).and_return container_reports
    end
    context "container has been collected" do
      let(:container_reports) do
        [
          double(collected_any?: true),
          double(collected_any?: false)
        ]
      end

      it "returns true" do
        expect(pr.collected_any?).to be true
      end
    end

    context "contains has NOT been collected" do
      let(:container_reports) do
        [
          double(collected_any?: false),
          double(collected_any?: false)
        ]
      end
      it "returns false" do
        expect(pr.collected_any?).to be false
      end
    end
  end

  describe "#report_file_name" do
    before do
      allow(Date).to receive(:today).and_return Date.new(2016, 12, 31)
    end

    it "returns a file name with today date" do
      expect(PickupReport.report_file_name).to eq "public/2016-12-31.txt"
    end
  end

  describe "#reports_to_export" do
    let(:p1) { create(:pickup) }
    let(:p2) { create(:pickup) }
    let(:p3) { create(:pickup, sent_at: Time.now) }
    let!(:pr1) { create(:pickup_report, pickup: p1) }
    let!(:pr2) { create(:pickup_report, pickup: p2) }
    let!(:pr3) { create(:pickup_report, pickup: p3) }

    it "returns reports which their pickups was not sent" do
      reports = PickupReport.reports_to_export

      pickups = reports.map(&:pickup).flatten
      expect(pickups.map(&:sent_at).uniq).to eq [nil]
      expect(reports.map(&:id)).not_to include pr3.id
    end

    it "doesn't return duplicates" do
      reports = PickupReport.reports_to_export

      expect(reports.map(&:id).uniq).to eq reports.map(&:id)
    end
  end

  describe ".create_approved_csv" do
    let(:pr) { create(:pickup_report) }

    before do
      pr
      create(:pickup_reason, priority_id: "01")
      create(:pickup_reason, priority_id: "06")

      allow_any_instance_of(ContainerReport).to receive(:approved?).and_return true
      allow(PickupReport).to receive(:reports_to_export).and_return [pr]
    end

    after do
      File.delete(PickupReport.report_file_name)
    end

    it "saves all reports lines to file" do
      PickupReport.create_approved_csv

      file = File.open(PickupReport.report_file_name).readlines.join.tr("\t", ",").split(/\n/)

      expect(file.size).to eq 1 + pr.supplier_reports.size * 1 * 1 # default food_types and container list is 1
    end

    # 5. each pickup should be marked as sent!
    it "should mark the pickup as sent" do
      PickupReport.create_approved_csv

      expect(pr.pickup.sent_at).not_to be_nil
    end

    context "nothing was collected for supplier" do
      before do
        allow(pr).to receive(:supplier_reports).and_return [sr]

        allow(PickupReport).to receive(:reports_to_export).and_return [pr]
      end

      # 1. nothing was collected for supplier and there is a reason
      # a. if single supplier
      #  -> file should contain 4 columns
      # b. if not single supplier
      # -> shouldn't be sent
      context "single supplier" do
        let(:sr) do
          double(:supplier_report, single_supplier?: true,
                                   collected_any?:   false,
                                   pickup_reason:    double(priority_id: 2),
                                   top_supplier:     double(priority_id: 1)).as_null_object
        end

        context "has reason" do
          before do
            allow(sr).to receive(:pickup_reason_id).and_return "8"
          end
          it "exports the not_collected" do
            expect(PickupReportsHelper).to receive(:export_not_collected_report).with(pr.pickup, sr).and_return ["line"]

            PickupReport.create_approved_csv
          end
        end

        context "has no reason" do
          before do
            allow(sr).to receive(:pickup_reason_id).and_return nil
          end
          it "doesn't export the line" do
            expect(PickupReportsHelper).not_to receive(:export_not_collected_report)

            PickupReport.create_approved_csv
          end
        end
      end

      context "not single supplier" do
        let(:sr) do
          double(:supplier_report, single_supplier?: false).as_null_object
        end
        it "doesn't export the line" do
          expect(PickupReportsHelper).not_to receive(:export_not_collected_report)

          PickupReport.create_approved_csv
        end
      end
    end

    # 2. container that was not collected should not be in the file
    context "when container was not collected" do
      before do
        allow(pr).to receive(:supplier_reports).and_return [sr]

        allow(PickupReport).to receive(:reports_to_export).and_return [pr]
      end
      let(:sr) do
        double(:supplier_report, food_type_reports: [
                 double(:food_report, container_reports: [
                          double(:container_report, collected_any?: false)
                        ])
               ]).as_null_object
      end

      it "should not be exported" do
        expect(PickupReportsHelper).not_to receive(:export_collected_report)

        PickupReport.create_approved_csv
      end
    end

    # 3. container that collected but was not approved should not be in the file
    context "when container was collected but not approved" do
      before do
        allow(pr).to receive(:supplier_reports).and_return [sr]

        allow(PickupReport).to receive(:reports_to_export).and_return [pr]
      end
      let(:sr) do
        double(:supplier_report, food_type_reports: [
                 double(:food_report, container_reports: [
                          double(:container_report, collected_any?: false, approved?: false)
                        ])
               ]).as_null_object
      end

      it "should not be exported" do
        expect(PickupReportsHelper).not_to receive(:export_collected_report)

        PickupReport.create_approved_csv
      end
    end
  end
end
