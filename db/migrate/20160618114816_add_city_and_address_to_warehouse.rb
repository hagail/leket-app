class AddCityAndAddressToWarehouse < ActiveRecord::Migration
  def change
    add_column :warehouses, :city, :string
    add_column :warehouses, :address, :string
  end
end
