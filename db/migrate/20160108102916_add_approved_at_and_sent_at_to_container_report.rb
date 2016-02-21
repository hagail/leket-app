class AddApprovedAtAndSentAtToContainerReport < ActiveRecord::Migration
  def change
    add_column :pickups, :approved_at, :datetime, default: nil
    add_column :pickups, :sent_at, :datetime, default: nil
  end
end
