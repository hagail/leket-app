class AddContainerToFoodTypeRelation < ActiveRecord::Migration
  def change
    add_reference :containers, :food_type, index: true
  end
end
