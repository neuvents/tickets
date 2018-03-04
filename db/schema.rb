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

ActiveRecord::Schema.define(version: 20180304120036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_types", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.integer "price", null: false
    t.string "currency", limit: 3, null: false
    t.jsonb "fields", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ticket_types_on_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "ticket_type_id", null: false
    t.string "uid", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.jsonb "fields", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
  end

  add_foreign_key "ticket_types", "events", on_delete: :restrict
  add_foreign_key "tickets", "ticket_types", on_delete: :restrict
end
