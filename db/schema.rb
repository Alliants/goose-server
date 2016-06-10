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

ActiveRecord::Schema.define(version: 20160610152053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_storages", force: :cascade do |t|
    t.string   "event_type"
    t.string   "action"
    t.json     "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pull_request_storages", force: :cascade do |t|
    t.string   "link"
    t.string   "title"
    t.string   "org"
    t.string   "repo"
    t.string   "owner"
    t.datetime "created_at"
    t.integer  "number_of_comments"
    t.integer  "original_id"
  end

  add_index "pull_request_storages", ["link"], name: "index_pull_request_storages_on_link", unique: true, using: :btree
  add_index "pull_request_storages", ["original_id"], name: "index_pull_request_storages_on_original_id", unique: true, using: :btree

  create_table "repository_storages", force: :cascade do |t|
    t.string "name"
  end

end
