# encoding: UTF-8

class PriorityParser
  PICKUPS_MAP = {
    id: 0,
    date: 1,
    user_id: 2,
    user_name: 3,
    user_phone: 4,
    user_email: 5,
    supplier_id: 7,
    supplier_name: 8,
    status: 9,
    sub_suppliers: Array.new(20) { |i| { id: i * 2 + 10, name: i * 2 + 11 } }
  }.freeze

  def self.process(pickups)
    pickups.each do |pickup|
      user = User.find_or_initialize_by(priority_id: pickup[PICKUPS_MAP[:user_id]])
      user.assign_attributes(name: pickup[PICKUPS_MAP[:user_name]],
                             phone: pickup[PICKUPS_MAP[:user_phone]],
                             email: pickup[PICKUPS_MAP[:user_email]])

      sub_suppliers = PICKUPS_MAP[:sub_suppliers].reject { |sub_supplier_maps| pickup[sub_supplier_maps[:id]].nil? }
                                                 .reject { |sub_supplier_maps| pickup[sub_supplier_maps[:id]] == pickup[PICKUPS_MAP[:supplier_id]] } # TODO: I am not sure if this a bug or not, but some lines contain sub supplier as themself.
                                                 .map do |sub_supplier_maps|
        sub_supplier = Supplier.find_or_initialize_by(priority_id: pickup[sub_supplier_maps[:id]])
        sub_supplier.assign_attributes(name: pickup[sub_supplier_maps[:name]])
        sub_supplier
      end

      supplier = Supplier.find_or_initialize_by(priority_id: pickup[PICKUPS_MAP[:supplier_id]])
      supplier.assign_attributes(name: pickup[PICKUPS_MAP[:supplier_name]],
                                 suppliers: sub_suppliers)

      new_pickup = Pickup.find_or_initialize_by(priority_id: pickup[PICKUPS_MAP[:id]])
      new_pickup.assign_attributes(date: Date.strptime(pickup[PICKUPS_MAP[:date]], '%d/%m/%y'),
                                   status: pickup[PICKUPS_MAP[:status]],
                                   supplier: supplier,
                                   user: user)

      new_pickup.save!
    end
  end
end
