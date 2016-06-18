# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require_relative '../lib/priority_parser'

pickups_from_file = CSV.read('spec/fixtures/isuf.txt', col_sep: "\t", encoding: 'Windows-1255')[1..-1]
PriorityParser.process(pickups_from_file)

### Set Food Types and Containers ###
[
  {
    priority_id: 'NP0004',
    name: "לחמים",
    image: 'bread.svg',
    containers: [
      # { priority_id: "56", name: "שקית סופר" },
      { priority_id: '01', name: "משטח" },
      { priority_id: '02', name: "מגש" }
    ]
  },
  { priority_id: 'NP0001', name: "מזון מבושל", image: 'cooked.svg', containers: [
    { priority_id: '51', name: "קופסה 2 ליטר" },
    { priority_id: '52', name: "קופסה 3 ליטר" },
    { priority_id: '53', name: "קופסה 10 ליטר" },
    { priority_id: '08', name: "יחידה" }
  ] },
  { priority_id: 'NP0003', name: "מאפים", image: 'pastries.svg', containers: [
    { priority_id: '56', name: "שקית סופר" },
    { priority_id: '57', name: "שק" },
    { priority_id: '52', name: "קופסה 3 ליטר" },
    { priority_id: '55', name: "קרטון" },
    { priority_id: '77', name: "מארז" }
  ] }
].each do |food_type_data|
  containers = food_type_data[:containers].map do |container_data|
    container = Container.find_or_initialize_by(priority_id: container_data[:priority_id])
    container.assign_attributes(name: container_data[:name])
    container.save!
    container
  end

  food_type = FoodType.find_or_initialize_by(priority_id: food_type_data[:priority_id])
  food_type.assign_attributes(name: food_type_data[:name], image: food_type_data[:image], containers: containers)
  food_type.save!
end

### Set Pickup Reasons ###
PickupReason.process_from_csv("db/pickup_reasons.csv")

### Set Warehouses ###
Warehouse.process_from_csv("db/warehouses.csv")
