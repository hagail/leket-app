FactoryGirl.define do
  factory :pickup_report do
    notes "Nothing here"
    created_at { Time.now }
    updated_at { Time.now }
    pickup
    warehouse
    pickup_reason

    transient do
      supplier_report_count 3
    end

    after(:create) do |pickup_report, evaluator|
      create_list(:supplier_report, evaluator.supplier_report_count, pickup_report: pickup_report)
    end
  end
end
