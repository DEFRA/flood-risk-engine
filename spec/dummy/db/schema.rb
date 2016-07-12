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

ActiveRecord::Schema.define(version: 20160712104613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flood_risk_engine_address_searches", force: :cascade do |t|
    t.integer  "enrollment_id", null: false
    t.string   "postcode"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "flood_risk_engine_address_searches", ["enrollment_id"], name: "index_flood_risk_engine_address_searches_on_enrollment_id", using: :btree

  create_table "flood_risk_engine_addresses", force: :cascade do |t|
    t.string   "premises",            limit: 200
    t.string   "street_address",      limit: 160
    t.string   "locality",            limit: 70
    t.string   "city",                limit: 30
    t.string   "postcode",            limit: 8
    t.integer  "county_province_id"
    t.string   "country_iso",         limit: 3
    t.integer  "address_type",                    default: 0,  null: false
    t.string   "organisation",        limit: 255, default: "", null: false
    t.date     "state_date"
    t.string   "blpu_state_code"
    t.string   "postal_address_code"
    t.string   "logical_status_code"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "uprn"
    t.string   "token"
  end

  add_index "flood_risk_engine_addresses", ["addressable_id", "addressable_type"], name: "by_addressable", using: :btree
  add_index "flood_risk_engine_addresses", ["token"], name: "index_flood_risk_engine_addresses_on_token", unique: true, using: :btree
  add_index "flood_risk_engine_addresses", ["uprn"], name: "index_flood_risk_engine_addresses_on_uprn", using: :btree

  create_table "flood_risk_engine_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.string   "event"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "flood_risk_engine_comments", ["commentable_type", "commentable_id"], name: "commentable_idx", using: :btree

  create_table "flood_risk_engine_contacts", force: :cascade do |t|
    t.integer  "contact_type",                            default: 0,  null: false
    t.integer  "title",                                   default: 0,  null: false
    t.string   "suffix"
    t.date     "date_of_birth"
    t.string   "position",                    limit: 255
    t.string   "email_address"
    t.string   "telephone_number"
    t.integer  "partnership_organisation_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "full_name",                   limit: 255, default: "", null: false
  end

  add_index "flood_risk_engine_contacts", ["email_address"], name: "index_flood_risk_engine_contacts_on_email_address", using: :btree
  add_index "flood_risk_engine_contacts", ["full_name"], name: "index_flood_risk_engine_contacts_on_full_name", using: :btree
  add_index "flood_risk_engine_contacts", ["partnership_organisation_id"], name: "fre_contacts_partnership_organisation_id", using: :btree

  create_table "flood_risk_engine_enrollments", force: :cascade do |t|
    t.integer  "applicant_contact_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "organisation_id"
    t.string   "step",                      limit: 50
    t.integer  "correspondence_contact_id"
    t.string   "token"
    t.integer  "secondary_contact_id"
    t.datetime "submitted_at"
    t.integer  "reference_number_id"
    t.integer  "updated_by_user_id"
  end

  add_index "flood_risk_engine_enrollments", ["applicant_contact_id"], name: "index_flood_risk_engine_enrollments_on_applicant_contact_id", using: :btree
  add_index "flood_risk_engine_enrollments", ["correspondence_contact_id"], name: "fre_enrollments_correspondence_contact_id", using: :btree
  add_index "flood_risk_engine_enrollments", ["organisation_id"], name: "index_flood_risk_engine_enrollments_on_organisation_id", using: :btree
  add_index "flood_risk_engine_enrollments", ["reference_number_id"], name: "index_flood_risk_engine_enrollments_on_reference_number_id", unique: true, using: :btree
  add_index "flood_risk_engine_enrollments", ["token"], name: "index_flood_risk_engine_enrollments_on_token", unique: true, using: :btree
  add_index "flood_risk_engine_enrollments", ["updated_by_user_id"], name: "index_flood_risk_engine_enrollments_on_updated_by_user_id", using: :btree

  create_table "flood_risk_engine_enrollments_exemptions", force: :cascade do |t|
    t.integer  "enrollment_id",                        null: false
    t.integer  "exemption_id",                         null: false
    t.integer  "status",               default: 0
    t.datetime "expires_at"
    t.datetime "valid_from"
    t.boolean  "asset_found",          default: false
    t.boolean  "salmonid_river_found", default: false
    t.integer  "deregister_reason"
    t.integer  "assistance_mode",      default: 0
  end

  add_index "flood_risk_engine_enrollments_exemptions", ["deregister_reason"], name: "by_deregister_reason", using: :btree
  add_index "flood_risk_engine_enrollments_exemptions", ["enrollment_id", "exemption_id"], name: "fre_enrollments_exemptions_enrollment_id_exemption_id", unique: true, using: :btree

  create_table "flood_risk_engine_exemptions", force: :cascade do |t|
    t.string   "code"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "code_number"
  end

  add_index "flood_risk_engine_exemptions", ["code_number"], name: "index_flood_risk_engine_exemptions_on_code_number", using: :btree

  create_table "flood_risk_engine_locations", force: :cascade do |t|
    t.string   "easting"
    t.string   "northing"
    t.string   "grid_reference"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.text     "description"
    t.string   "dredging_length"
    t.integer  "water_boundary_area_id"
  end

  add_index "flood_risk_engine_locations", ["locatable_id", "locatable_type"], name: "by_locatable", using: :btree

  create_table "flood_risk_engine_organisations", force: :cascade do |t|
    t.string   "name"
    t.integer  "contact_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "org_type"
    t.string   "registration_number", limit: 12
    t.text     "searchable_content"
  end

  add_index "flood_risk_engine_organisations", ["contact_id"], name: "index_flood_risk_engine_organisations_on_contact_id", using: :btree
  add_index "flood_risk_engine_organisations", ["org_type"], name: "index_flood_risk_engine_organisations_on_org_type", using: :btree
  add_index "flood_risk_engine_organisations", ["registration_number"], name: "index_flood_risk_engine_organisations_on_registration_number", using: :btree
  add_index "flood_risk_engine_organisations", ["searchable_content"], name: "index_flood_risk_engine_organisations_on_searchable_content", using: :btree

  create_table "flood_risk_engine_partners", force: :cascade do |t|
    t.integer  "organisation_id"
    t.integer  "contact_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "flood_risk_engine_partners", ["contact_id"], name: "index_flood_risk_engine_partners_on_contact_id", using: :btree
  add_index "flood_risk_engine_partners", ["organisation_id"], name: "index_flood_risk_engine_partners_on_organisation_id", using: :btree

  create_table "flood_risk_engine_reference_numbers", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "flood_risk_engine_reference_numbers", ["number"], name: "index_flood_risk_engine_reference_numbers_on_number", using: :btree

  create_table "flood_risk_engine_water_boundary_areas", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "long_name",  null: false
    t.string   "short_name"
    t.integer  "area_id"
    t.string   "area_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "flood_risk_engine_water_boundary_areas", ["code"], name: "fre_water_boundary_areas_code", unique: true, using: :btree

  create_table "not_in_engines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  add_foreign_key "flood_risk_engine_address_searches", "flood_risk_engine_enrollments", column: "enrollment_id"
  add_foreign_key "flood_risk_engine_contacts", "flood_risk_engine_organisations", column: "partnership_organisation_id"
  add_foreign_key "flood_risk_engine_enrollments", "flood_risk_engine_contacts", column: "applicant_contact_id"
  add_foreign_key "flood_risk_engine_enrollments", "flood_risk_engine_contacts", column: "secondary_contact_id"
  add_foreign_key "flood_risk_engine_enrollments", "flood_risk_engine_organisations", column: "organisation_id"
  add_foreign_key "flood_risk_engine_enrollments_exemptions", "flood_risk_engine_enrollments", column: "enrollment_id"
  add_foreign_key "flood_risk_engine_enrollments_exemptions", "flood_risk_engine_exemptions", column: "exemption_id"
  add_foreign_key "flood_risk_engine_organisations", "flood_risk_engine_contacts", column: "contact_id"
  add_foreign_key "flood_risk_engine_partners", "flood_risk_engine_contacts", column: "contact_id"
  add_foreign_key "flood_risk_engine_partners", "flood_risk_engine_organisations", column: "organisation_id"
end
