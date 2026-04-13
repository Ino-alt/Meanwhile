# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_13_094814) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "country_code"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "timezone"
    t.datetime "updated_at", null: false
    t.index ["country_code"], name: "index_countries_on_country_code", unique: true
  end

  create_table "entries", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "moment_id"
    t.datetime "updated_at", null: false
    t.index ["moment_id"], name: "index_entries_on_moment_id"
  end

  create_table "moments", force: :cascade do |t|
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.text "fixed_text"
    t.datetime "occurred_at"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["country_id"], name: "index_moments_on_country_id"
    t.index ["user_id"], name: "index_moments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "guest_id", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_users_on_guest_id", unique: true
  end
end
