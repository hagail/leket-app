class CreateContainerReports < ActiveRecord::Migration
  def change
    create_table :container_reports do |t|
      t.timestamps null: false
    end
    add_reference :container_reports, :container, index: true
    add_reference :container_reports, :food_type_report, index: true
  end
end
