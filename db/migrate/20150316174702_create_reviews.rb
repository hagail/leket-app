class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :priority_id
      t.string :status
      t.string :notes

      t.timestamps null: false
    end

    add_reference :reviews, :pickup, index: true
    add_reference :reviews, :warehouse, index: true
    add_reference :reviews, :pickup_reason, index: true
  end
end
