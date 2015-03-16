class CreateSupplierReviews < ActiveRecord::Migration
  def change
    create_table :supplier_reviews do |t|
      t.integer :quantity

      t.timestamps null: false
    end

    add_reference :supplier_reviews, :review, index: true
    add_reference :supplier_reviews, :supplier, index: true
    add_reference :supplier_reviews, :container, index: true
    add_reference :supplier_reviews, :food_type, index: true
  end
end
