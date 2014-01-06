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

ActiveRecord::Schema.define(version: 20140106205459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: true do |t|
    t.string   "email"
    t.integer  "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rally_id"
  end

  add_index "attendees", ["rally_id"], name: "index_attendees_on_rally_id", using: :btree

  create_table "movements", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "video"
  end

  create_table "rallies", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.integer  "coordinator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movement_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "rallies", ["movement_id"], name: "index_rallies_on_movement_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movement_id"
    t.boolean  "small_rally"
    t.boolean  "medium_rally"
    t.boolean  "big_rally"
  end

  add_index "tasks", ["movement_id"], name: "index_tasks_on_movement_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "movement_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zipcodes", force: true do |t|
    t.string "zip"
    t.string "city"
    t.string "state"
    t.string "state_abbreviation"
    t.float  "latitude"
    t.float  "longitude"
  end

end
