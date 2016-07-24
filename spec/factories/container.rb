FactoryGirl.define do
  factory :container do
    priority_id { rand(99) }
    name "Extra Large Tray"
  end
end
