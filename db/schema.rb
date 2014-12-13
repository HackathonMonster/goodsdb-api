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

ActiveRecord::Schema.define(version: 20141213100729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_events", force: true do |t|
    t.integer  "status",     default: 0, null: false
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_events", ["item_id"], name: "index_item_events_on_item_id", using: :btree
  add_index "item_events", ["status"], name: "index_item_events_on_status", using: :btree

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["owner_id"], name: "index_items_on_owner_id", using: :btree

  create_table "items_tags", id: false, force: true do |t|
    t.integer "item_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "items_tags", ["item_id"], name: "index_items_tags_on_item_id", using: :btree
  add_index "items_tags", ["tag_id"], name: "index_items_tags_on_tag_id", using: :btree

  create_table "pictures", force: true do |t|
    t.string   "image"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["item_id"], name: "index_pictures_on_item_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
    t.string   "email"
    t.string   "profile_picture"
    t.string   "facebook_id"
    t.string   "facebook_token"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

end
