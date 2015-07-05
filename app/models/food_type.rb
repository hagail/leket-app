class FoodType < ActiveRecord::Base
  has_many :containers
end
