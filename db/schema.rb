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

ActiveRecord::Schema.define(version: 20160227221651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_requests", force: :cascade do |t|
    t.integer  "offset_in_seconds"
    t.integer  "event_id"
    t.date     "offset_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alert_requests", ["event_id"], name: "index_alert_requests_on_event_id", using: :btree

  create_table "alerts", force: :cascade do |t|
    t.integer  "alert_request_id"
    t.text     "body"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["alert_request_id"], name: "index_alerts_on_alert_request_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "event_type"
    t.date     "date"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "alert_requests", "events"
  add_foreign_key "alerts", "alert_requests"
end
