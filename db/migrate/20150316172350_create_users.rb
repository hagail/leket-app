class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :priority_id
      t.string :email
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
  end
end
