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

ActiveRecord::Schema.define(version: 20140609194750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attendance_id"
  end

  add_index "assignments", ["attendance_id", "task_id"], name: "index_assignments_on_attendance_id_and_task_id", unique: true, using: :btree
  add_index "assignments", ["task_id"], name: "index_assignments_on_task_id", using: :btree

  create_table "attachments", force: true do |t|
    t.integer  "event_id"
    t.integer  "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flyer_file_name"
    t.string   "flyer_content_type"
    t.integer  "flyer_file_size"
    t.datetime "flyer_updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.boolean "point_person", default: false
    t.text    "notes"
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id", using: :btree
  add_index "attendances", ["user_id", "event_id"], name: "index_attendances_on_user_id_and_event_id", unique: true, using: :btree
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree

  create_table "event_types", force: true do |t|
    t.string "name"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movement_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location_details"
    t.boolean  "approved"
    t.integer  "host_id"
    t.integer  "event_type_id"
    t.string   "state"
    t.string   "address2"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "forum_option",       default: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "flyer_file_name"
    t.string   "flyer_content_type"
    t.integer  "flyer_file_size"
    t.datetime "flyer_updated_at"
  end

  add_index "events", ["host_id"], name: "index_events_on_host_id", using: :btree
  add_index "events", ["movement_id"], name: "index_events_on_movement_id", using: :btree

  create_table "movements", force: true do |t|
    t.string   "name"
    t.text     "tagline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "video"
    t.text     "call_to_action"
    t.text     "extended_description"
    t.boolean  "published",            default: false
    t.text     "about_creator"
    t.integer  "parent_id"
    t.string   "location"
  end

  create_table "ownerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "tasks", ["event_id"], name: "index_tasks_on_event_id", using: :btree

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
    t.string   "phone"
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
