class AddUserDisplayedToPickupReasons < ActiveRecord::Migration
  def change
    add_column :pickup_reasons, :user_displayed, :boolean, default: false
  end
end
