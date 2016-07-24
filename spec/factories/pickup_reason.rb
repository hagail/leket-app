FactoryGirl.define do
  factory :pickup_reason do
    priority_id { %w(01 02 03 04 05 06).sample }
    name "Some Reason"

    user_displayed { %w(02 04 05).include?(priority_id) ? true : false }
  end
end
