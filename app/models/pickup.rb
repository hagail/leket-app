class Pickup < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :user
  has_one :pickup_report
  alias_attribute :report, :pickup_report
end
