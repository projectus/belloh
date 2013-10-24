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

ActiveRecord::Schema.define(version: 20131024003816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hub_posts", force: true do |t|
    t.string   "content"
    t.string   "sender_desc"
    t.string   "receiver_desc"
    t.string   "mood",           default: "neutral"
    t.integer  "virtual_hub_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hub_posts", ["sender_id"], name: "index_hub_posts_on_sender_id", using: :btree
  add_index "hub_posts", ["virtual_hub_id"], name: "index_hub_posts_on_virtual_hub_id", using: :btree

  create_table "posts", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "country"
    t.text     "content"
    t.string   "sender_desc"
    t.string   "receiver_desc"
    t.string   "mood",          default: "neutral"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["latitude", "longitude"], name: "index_posts_on_latitude_and_longitude", using: :btree
  add_index "posts", ["sender_id"], name: "index_posts_on_sender_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username", "email"], name: "index_users_on_username_and_email", unique: true, using: :btree

  create_table "virtual_hubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.text     "description"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "virtual_hubs", ["admin_id"], name: "index_virtual_hubs_on_admin_id", using: :btree
  add_index "virtual_hubs", ["name"], name: "index_virtual_hubs_on_name", unique: true, using: :btree

end
