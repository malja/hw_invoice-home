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

ActiveRecord::Schema.define(version: 2023_03_21_182407) do

  create_table "addresses", force: :cascade do |t|
    t.string "street", null: false
    t.string "town", null: false
    t.string "zip_code", null: false
    t.string "state"
    t.string "country", limit: 2, null: false
    t.integer "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_addresses_on_person_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email_address", null: false
    t.text "comment"
    t.integer "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_emails_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "salutation", default: "Mr."
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.integer "ssn"
    t.date "birth_date"
    t.text "comment"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "phone_number", null: false
    t.text "comment"
    t.integer "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_phone_numbers_on_person_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "active", default: true, null: false
  end

  add_foreign_key "addresses", "people"
  add_foreign_key "emails", "people"
  add_foreign_key "people", "users"
  add_foreign_key "phone_numbers", "people"
end
