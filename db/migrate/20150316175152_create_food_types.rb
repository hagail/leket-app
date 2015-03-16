class CreateFoodTypes < ActiveRecord::Migration
  def change
    create_table :food_types do |t|
      t.string :priority_id
      t.string :name

      t.timestamps null: false
    end
  end
end
