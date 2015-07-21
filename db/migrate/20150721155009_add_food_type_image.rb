class AddFoodTypeImage < ActiveRecord::Migration
  def change
    add_column :food_types, :image, :string
  end
end
