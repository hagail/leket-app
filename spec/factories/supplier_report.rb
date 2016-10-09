FactoryGirl.define do
  factory :supplier_report do
    supplier

    transient do
      food_type_report_count 3
    end
    after(:create) do |supplier_report, evaluator|
      create_list(:food_type_report, evaluator.food_type_report_count, supplier_report: supplier_report)
    end
  end
end
