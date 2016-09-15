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

ActiveRecord::Schema.define(version: 20160915023611) do

  create_table "applicant_statuses", force: :cascade do |t|
    t.integer  "team_member_id", limit: 4,   null: false
    t.integer  "applicant_id",   limit: 4,   null: false
    t.string   "status",         limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "applicant_statuses", ["applicant_id"], name: "index_applicant_statuses_on_applicant_id", using: :btree
  add_index "applicant_statuses", ["team_member_id"], name: "index_applicant_statuses_on_team_member_id", using: :btree

  create_table "applicants", force: :cascade do |t|
    t.integer  "team_member_id",   limit: 4
    t.integer  "latest_status_id", limit: 4
    t.string   "nickname",         limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "applicants", ["latest_status_id"], name: "index_applicants_on_latest_status_id", using: :btree
  add_index "applicants", ["team_member_id"], name: "index_applicants_on_team_member_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "team_members", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255, null: false
    t.string   "email",      limit: 255, null: false
    t.string   "phone",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "team_members", ["user_id"], name: "index_team_members_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",      limit: 255
    t.string   "uid",           limit: 255
    t.string   "name",          limit: 255
    t.string   "refresh_token", limit: 255
    t.string   "access_token",  limit: 255
    t.datetime "expires"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "applicant_statuses", "applicants"
  add_foreign_key "applicant_statuses", "team_members"
  add_foreign_key "applicants", "team_members"
  add_foreign_key "team_members", "users"
end
