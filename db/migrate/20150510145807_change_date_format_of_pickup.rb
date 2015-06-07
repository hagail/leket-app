class ChangeDateFormatOfPickup < ActiveRecord::Migration
  def up
    change_column :pickups, :date, :date
  end

  def down
    change_column :pickups, :date, :datetime
  end
end
