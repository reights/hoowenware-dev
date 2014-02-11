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

ActiveRecord::Schema.define(version: 20140211061503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "groups", force: true do |t|
    t.string   "name",       default: "",   null: false
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "group_id"
    t.string   "email"
    t.string   "role"
    t.integer  "last_updated_by"
    t.boolean  "is_active",       default: false
    t.boolean  "is_admin",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "thing_id"
    t.string   "thing_type"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.string   "title"
    t.string   "hash_tag"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "location"
    t.boolean  "is_private",     default: false
    t.boolean  "hide_guestlist", default: false
    t.boolean  "is_active",      default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.boolean  "is_admin",               default: false
    t.string   "uid"
    t.string   "provider"
    t.hstore   "oauth_cred"
    t.string   "gender"
    t.string   "status"
    t.string   "zip_code"
    t.string   "mobile_number"
    t.string   "skype_id"
    t.string   "dietary_pref"
    t.string   "roommate_pref"
    t.boolean  "profile_updated",        default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
