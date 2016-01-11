# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160108102916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "container_reports", force: :cascade do |t|
    t.integer  "quantity",            default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "container_id"
    t.integer  "food_type_report_id"
  end

  add_index "container_reports", ["container_id"], name: "index_container_reports_on_container_id", using: :btree
  add_index "container_reports", ["food_type_report_id"], name: "index_container_reports_on_food_type_report_id", using: :btree

  create_table "containers", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "food_type_id"
  end

  add_index "containers", ["food_type_id"], name: "index_containers_on_food_type_id", using: :btree

  create_table "food_type_reports", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "pickup_report_id"
    t.integer  "food_type_id"
    t.integer  "supplier_report_id"
  end

  add_index "food_type_reports", ["food_type_id"], name: "index_food_type_reports_on_food_type_id", using: :btree
  add_index "food_type_reports", ["pickup_report_id"], name: "index_food_type_reports_on_pickup_report_id", using: :btree
  add_index "food_type_reports", ["supplier_report_id"], name: "index_food_type_reports_on_supplier_report_id", using: :btree

  create_table "food_types", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  create_table "pickup_reasons", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pickup_reports", force: :cascade do |t|
    t.boolean  "food_picked_up"
    t.string   "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "pickup_id"
    t.integer  "warehouse_id"
    t.integer  "pickup_reason_id"
  end

  add_index "pickup_reports", ["pickup_id"], name: "index_pickup_reports_on_pickup_id", using: :btree
  add_index "pickup_reports", ["pickup_reason_id"], name: "index_pickup_reports_on_pickup_reason_id", using: :btree
  add_index "pickup_reports", ["warehouse_id"], name: "index_pickup_reports_on_warehouse_id", using: :btree

  create_table "pickups", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "status"
    t.date     "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "supplier_id"
    t.integer  "user_id"
    t.datetime "approved_at"
    t.datetime "sent_at"
  end

  add_index "pickups", ["supplier_id"], name: "index_pickups_on_supplier_id", using: :btree
  add_index "pickups", ["user_id"], name: "index_pickups_on_user_id", using: :btree

  create_table "supplier_reports", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "pickup_report_id"
    t.integer  "supplier_id"
  end

  add_index "supplier_reports", ["pickup_report_id"], name: "index_supplier_reports_on_pickup_report_id", using: :btree
  add_index "supplier_reports", ["supplier_id"], name: "index_supplier_reports_on_supplier_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "supplier_id"
  end

  add_index "suppliers", ["supplier_id"], name: "index_suppliers_on_supplier_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "email"
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "warehouses", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
