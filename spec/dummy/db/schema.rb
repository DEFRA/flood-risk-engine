# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_02_151907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flood_risk_engine_address_searches", id: :serial, force: :cascade do |t|
    t.integer "enrollment_id", null: false
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id"], name: "index_flood_risk_engine_address_searches_on_enrollment_id"
  end

  create_table "flood_risk_engine_addresses", id: :serial, force: :cascade do |t|
    t.string "premises", limit: 200
    t.string "street_address", limit: 160
    t.string "locality", limit: 70
    t.string "city", limit: 30
    t.string "postcode", limit: 8
    t.integer "county_province_id"
    t.string "country_iso", limit: 3
    t.integer "address_type", default: 0, null: false
    t.string "organisation", limit: 255, default: "", null: false
    t.date "state_date"
    t.string "blpu_state_code"
    t.string "postal_address_code"
    t.string "logical_status_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "addressable_id"
    t.string "addressable_type"
    t.string "uprn"
    t.string "token"
    t.index ["addressable_id", "addressable_type"], name: "by_addressable"
    t.index ["token"], name: "index_flood_risk_engine_addresses_on_token", unique: true
    t.index ["uprn"], name: "index_flood_risk_engine_addresses_on_uprn"
  end

  create_table "flood_risk_engine_comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "content"
    t.string "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "commentable_idx"
  end

  create_table "flood_risk_engine_contacts", id: :serial, force: :cascade do |t|
    t.integer "contact_type", default: 0, null: false
    t.integer "title", default: 0, null: false
    t.string "suffix"
    t.date "date_of_birth"
    t.string "position", limit: 255
    t.string "email_address"
    t.string "telephone_number"
    t.integer "partnership_organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", limit: 255, default: "", null: false
    t.index ["email_address"], name: "index_flood_risk_engine_contacts_on_email_address"
    t.index ["full_name"], name: "index_flood_risk_engine_contacts_on_full_name"
    t.index ["partnership_organisation_id"], name: "fre_contacts_partnership_organisation_id"
  end

  create_table "flood_risk_engine_enrollments", id: :serial, force: :cascade do |t|
    t.integer "applicant_contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organisation_id"
    t.string "step", limit: 50
    t.integer "correspondence_contact_id"
    t.string "token"
    t.integer "secondary_contact_id"
    t.datetime "submitted_at"
    t.integer "reference_number_id"
    t.integer "updated_by_user_id"
    t.index ["applicant_contact_id"], name: "index_flood_risk_engine_enrollments_on_applicant_contact_id"
    t.index ["correspondence_contact_id"], name: "fre_enrollments_correspondence_contact_id"
    t.index ["organisation_id"], name: "index_flood_risk_engine_enrollments_on_organisation_id"
    t.index ["reference_number_id"], name: "index_flood_risk_engine_enrollments_on_reference_number_id", unique: true
    t.index ["secondary_contact_id"], name: "index_flood_risk_engine_enrollments_on_secondary_contact_id"
    t.index ["token"], name: "index_flood_risk_engine_enrollments_on_token", unique: true
    t.index ["updated_by_user_id"], name: "index_flood_risk_engine_enrollments_on_updated_by_user_id"
  end

  create_table "flood_risk_engine_enrollments_exemptions", id: :serial, force: :cascade do |t|
    t.integer "enrollment_id", null: false
    t.integer "exemption_id", null: false
    t.integer "status", default: 0
    t.datetime "expires_at"
    t.datetime "valid_from"
    t.boolean "asset_found", default: false
    t.boolean "salmonid_river_found", default: false
    t.integer "deregister_reason"
    t.integer "assistance_mode", default: 0
    t.index ["deregister_reason"], name: "by_deregister_reason"
    t.index ["enrollment_id", "exemption_id"], name: "fre_enrollments_exemptions_enrollment_id_exemption_id", unique: true
  end

  create_table "flood_risk_engine_exemptions", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "summary"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code_number"
    t.index ["code_number"], name: "index_flood_risk_engine_exemptions_on_code_number"
  end

  create_table "flood_risk_engine_locations", id: :serial, force: :cascade do |t|
    t.string "easting"
    t.string "northing"
    t.string "grid_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "locatable_id"
    t.string "locatable_type"
    t.text "description"
    t.string "dredging_length"
    t.integer "water_management_area_id"
    t.index ["locatable_id", "locatable_type"], name: "by_locatable"
  end

  create_table "flood_risk_engine_organisations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "org_type"
    t.string "registration_number", limit: 12
    t.text "searchable_content"
    t.index ["org_type"], name: "index_flood_risk_engine_organisations_on_org_type"
    t.index ["registration_number"], name: "index_flood_risk_engine_organisations_on_registration_number"
    t.index ["searchable_content"], name: "index_flood_risk_engine_organisations_on_searchable_content"
  end

  create_table "flood_risk_engine_partners", id: :serial, force: :cascade do |t|
    t.integer "organisation_id"
    t.integer "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_flood_risk_engine_partners_on_contact_id"
    t.index ["organisation_id"], name: "index_flood_risk_engine_partners_on_organisation_id"
  end

  create_table "flood_risk_engine_reference_numbers", id: :serial, force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_flood_risk_engine_reference_numbers_on_number"
  end

  create_table "flood_risk_engine_water_management_areas", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.string "long_name", null: false
    t.string "short_name"
    t.integer "area_id"
    t.string "area_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "fre_water_boundary_areas_code", unique: true
  end

  create_table "not_in_engines", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "transient_addresses", force: :cascade do |t|
    t.string "premises", limit: 200
    t.string "street_address", limit: 160
    t.string "locality", limit: 70
    t.string "city", limit: 30
    t.string "postcode", limit: 8
    t.integer "county_province_id"
    t.string "country_iso", limit: 3
    t.integer "address_type", default: 0, null: false
    t.string "organisation", limit: 255, default: ""
    t.date "state_date"
    t.string "blpu_state_code"
    t.string "postal_address_code"
    t.string "logical_status_code"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "uprn"
    t.string "token"
    t.index ["addressable_type", "addressable_id"], name: "index_addressables"
  end

  create_table "transient_people", force: :cascade do |t|
    t.string "full_name"
    t.bigint "transient_registration_id"
    t.index ["transient_registration_id"], name: "index_transient_people_on_transient_registration_id"
  end

  create_table "transient_registration_exemptions", force: :cascade do |t|
    t.string "state"
    t.date "registered_on"
    t.date "expires_on"
    t.bigint "transient_registration_id"
    t.bigint "flood_risk_engine_exemption_id"
    t.index ["flood_risk_engine_exemption_id"], name: "exemption_id"
    t.index ["transient_registration_id"], name: "transient_registration_id"
  end

  create_table "transient_registrations", force: :cascade do |t|
    t.string "token"
    t.string "workflow_state"
    t.string "type", default: "FloodRiskEngine::NewRegistration", null: false
    t.string "additional_contact_email"
    t.string "business_type"
    t.string "company_name"
    t.string "company_number"
    t.string "contact_email"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_position"
    t.boolean "declaration"
    t.string "temp_company_postcode"
    t.string "temp_grid_reference"
    t.text "temp_site_description"
    t.boolean "address_finder_error", default: false
    t.integer "dredging_length"
    t.index ["token"], name: "index_transient_registrations_on_token", unique: true
  end

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
  add_foreign_key "transient_people", "transient_registrations"
end
