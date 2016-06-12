class AddApprovedAtToContainerReport < ActiveRecord::Migration
  def change
    add_column :container_reports, :approved_at, :datetime, default: nil
  end
end
