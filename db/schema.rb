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

ActiveRecord::Schema.define(version: 20160916020833) do

  create_table "applicant_status_notes", force: :cascade do |t|
    t.integer  "applicant_status_id", limit: 4
    t.text     "content",             limit: 65535
    t.integer  "team_member_id",      limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "applicant_status_notes", ["applicant_status_id"], name: "index_applicant_status_notes_on_applicant_status_id", using: :btree
  add_index "applicant_status_notes", ["team_member_id"], name: "index_applicant_status_notes_on_team_member_id", using: :btree

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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "form_details",     limit: 65535
  end

  add_index "applicants", ["latest_status_id"], name: "index_applicants_on_latest_status_id", using: :btree
  add_index "applicants", ["team_member_id"], name: "index_applicants_on_team_member_id", using: :btree

  create_table "application_status_notes", force: :cascade do |t|
    t.integer  "application_status_id", limit: 4
    t.text     "content",               limit: 65535
    t.integer  "team_member_id",        limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "application_status_notes", ["application_status_id"], name: "index_application_status_notes_on_application_status_id", using: :btree
  add_index "application_status_notes", ["team_member_id"], name: "index_application_status_notes_on_team_member_id", using: :btree

  create_table "application_statuses", force: :cascade do |t|
    t.integer  "application_id", limit: 4,     null: false
    t.integer  "team_member_id", limit: 4,     null: false
    t.string   "status",         limit: 255,   null: false
    t.string   "contact_method", limit: 255
    t.string   "contact_detail", limit: 255
    t.text     "content",        limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "application_statuses", ["application_id"], name: "index_application_statuses_on_application_id", using: :btree
  add_index "application_statuses", ["team_member_id"], name: "index_application_statuses_on_team_member_id", using: :btree

  create_table "applications", force: :cascade do |t|
    t.integer  "applicant_id",     limit: 4,   null: false
    t.string   "category",         limit: 255, null: false
    t.integer  "latest_status_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "applications", ["applicant_id"], name: "index_applications_on_applicant_id", using: :btree
  add_index "applications", ["latest_status_id"], name: "index_applications_on_latest_status_id", using: :btree

  create_table "cheques", force: :cascade do |t|
    t.integer  "team_member_id", limit: 4,                  null: false
    t.integer  "application_id", limit: 4,                  null: false
    t.decimal  "amount",                     precision: 10, null: false
    t.string   "payee",          limit: 255,                null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.datetime "spent_at"
    t.datetime "cancelled_at"
  end

  add_index "cheques", ["application_id"], name: "index_cheques_on_application_id", using: :btree
  add_index "cheques", ["team_member_id"], name: "index_cheques_on_team_member_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "team_members", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "name",           limit: 255, null: false
    t.string   "email",          limit: 255, null: false
    t.string   "phone",          limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "promoted_by_id", limit: 4
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

  create_table "votes", force: :cascade do |t|
    t.integer  "application_id", limit: 4
    t.integer  "team_member_id", limit: 4
    t.string   "vote",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "votes", ["application_id"], name: "index_votes_on_application_id", using: :btree
  add_index "votes", ["team_member_id"], name: "index_votes_on_team_member_id", using: :btree

  add_foreign_key "applicant_status_notes", "applicant_statuses"
  add_foreign_key "applicant_status_notes", "team_members"
  add_foreign_key "applicant_statuses", "applicants"
  add_foreign_key "applicant_statuses", "team_members"
  add_foreign_key "applicants", "team_members"
  add_foreign_key "application_status_notes", "application_statuses"
  add_foreign_key "application_status_notes", "team_members"
  add_foreign_key "application_statuses", "applications"
  add_foreign_key "application_statuses", "team_members"
  add_foreign_key "applications", "applicants"
  add_foreign_key "cheques", "applications"
  add_foreign_key "cheques", "team_members"
  add_foreign_key "team_members", "users"
  add_foreign_key "votes", "applications"
  add_foreign_key "votes", "team_members"
end
