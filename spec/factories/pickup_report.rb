FactoryGirl.define do
  factory :pickup_report do
    notes "Nothing here"
    created_at { Time.now }
    updated_at { Time.now }
    pickup
    warehouse

    transient do
      supplier_report_count 3
    end

    after(:create) do |pickup_report, evaluator|
      create_list(:supplier_report, evaluator.supplier_report_count, food_type_report_count: 1, pickup_report: pickup_report)
    end
  end
end
