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

ActiveRecord::Schema.define(version: 20150316174935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pickup_reasons", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pickups", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "status"
    t.datetime "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "supplier_id"
    t.integer  "user_id"
  end

  add_index "pickups", ["supplier_id"], name: "index_pickups_on_supplier_id", using: :btree
  add_index "pickups", ["user_id"], name: "index_pickups_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "priority_id"
    t.string   "status"
    t.string   "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "pickup_id"
    t.integer  "warehouse_id"
    t.integer  "pickup_reason_id"
  end

  add_index "reviews", ["pickup_id"], name: "index_reviews_on_pickup_id", using: :btree
  add_index "reviews", ["pickup_reason_id"], name: "index_reviews_on_pickup_reason_id", using: :btree
  add_index "reviews", ["warehouse_id"], name: "index_reviews_on_warehouse_id", using: :btree

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
