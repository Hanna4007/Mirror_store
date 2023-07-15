# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_15_144142) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "delivery_type"
    t.string "post"
    t.string "receiver_name"
    t.string "receiver_surname"
    t.string "receiver_phone_number"
    t.string "city"
    t.string "receiver_address"
    t.integer "post_office_number"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "region"
    t.index ["order_id"], name: "index_deliveries_on_order_id"
  end

  create_table "mirrors", force: :cascade do |t|
    t.string "name"
    t.integer "height"
    t.integer "width"
    t.integer "glass_thickness"
    t.string "light"
    t.boolean "heater", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_square"
    t.string "installation"
    t.string "lamp"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "mirror_id"
    t.integer "order_id"
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "total_price_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "height"
    t.integer "width"
    t.decimal "price_square"
    t.integer "glass_thickness"
    t.string "light"
    t.boolean "heater"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "status", default: "in progress", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "deliveries", "orders"
  add_foreign_key "orders", "users"
end
