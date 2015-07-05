class ContainerReport < ActiveRecord::Base
  belongs_to :container
  belongs_to :food_type_report
end