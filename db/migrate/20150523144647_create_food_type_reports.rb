class CreateFoodTypeReports < ActiveRecord::Migration
  def change
    create_table :food_type_reports do |t|
      t.timestamps null: false
    end

    add_reference :food_type_reports, :pickup_report, index: true
    add_reference :food_type_reports, :food_type, index: true
  end
end
