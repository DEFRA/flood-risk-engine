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

ActiveRecord::Schema.define(version: 201604131212938) do
  create_table "flood_risk_engine_addresses", force: :cascade do |t|
    t.string   "premises",            limit: 200
    t.string   "street_address",      limit: 160
    t.string   "locality",            limit: 70
    t.string   "city",                limit: 30
    t.string   "postcode",            limit: 8
    t.integer  "county_province_id"
    t.string   "country_iso", limit: 3
    t.integer  "address_type", default: 0, null: false
    t.string   "organisation", limit: 255, default: "", null: false
    t.integer  "contact_id"
    t.date     "state_date"
    t.string   "blpu_state_code"
    t.string   "postal_address_code"
    t.string   "logical_status_code"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "flood_risk_engine_contacts", force: :cascade do |t|
    t.integer  "contact_type",                default: 0, null: false
    t.integer  "title",                       default: 0, null: false
    t.string   "suffix"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "position"
    t.string   "email_address"
    t.string   "telephone_number"
    t.integer  "partnership_organisation_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "flood_risk_engine_contacts", ["email_address"], name: "index_flood_risk_engine_contacts_on_email_address"

  create_table "flood_risk_engine_enrollments", force: :cascade do |t|
    t.boolean  "dummy_boolean"
    t.string   "dummy_string1"
    t.string   "dummy_string2"
    t.integer  "applicant_contact_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "organisation_id"
    t.string   "step", limit: 50
    t.integer  "site_address_id"
  end

  create_table "flood_risk_engine_enrollments_exemptions", force: :cascade do |t|
    t.integer  "enrollment_id",             null: false
    t.integer  "exemption_id",              null: false
    t.integer  "status", default: 0
    t.datetime "expires_at"
    t.datetime "valid_from"
  end

  create_table "flood_risk_engine_exemptions", force: :cascade do |t|
    t.string   "code"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "flood_risk_engine_locations", force: :cascade do |t|
    t.integer  "address_id"
    t.float    "easting"
    t.float    "northing"
    t.string   "grid_reference"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "flood_risk_engine_locations", ["address_id"], name: "index_flood_risk_engine_locations_on_address_id"

  create_table "flood_risk_engine_organisations", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "contact_id"
    t.string   "company_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "not_in_engines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
