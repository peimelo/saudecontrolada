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

ActiveRecord::Schema.define(version: 20170129020728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email",      null: false
    t.text     "message",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exams", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
    t.index ["name", "parent_id", "unit_id"], name: "index_exams_on_name_and_parent_id_and_unit_id", unique: true, using: :btree
  end

  create_table "exams_results", force: :cascade do |t|
    t.decimal  "value",      precision: 10, scale: 2, null: false
    t.integer  "exam_id",                             null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "result_id",                           null: false
    t.index ["exam_id", "result_id"], name: "index_exams_results_on_exam_id_and_result_id", unique: true, using: :btree
  end

  create_table "foods", force: :cascade do |t|
    t.string  "name",                            null: false
    t.string  "measure",                         null: false
    t.decimal "amount",  precision: 5, scale: 2
    t.decimal "cho",     precision: 5, scale: 2, null: false
    t.decimal "kcal",    precision: 6, scale: 2, null: false
    t.index ["name", "measure"], name: "index_foods_on_name_and_measure", unique: true, using: :btree
  end

  create_table "references", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_references_on_name", unique: true, using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.date     "date",        null: false
    t.string   "description", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["date", "description", "user_id"], name: "index_results_on_date_and_description_and_user_id", unique: true, using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_units_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "name",                                   null: false
    t.string   "gender",                                 null: false
    t.date     "date_of_birth",                          null: false
    t.string   "password_digest",        default: "",    null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "valores", force: :cascade do |t|
    t.string   "gender"
    t.decimal  "idade_inferior", precision: 6,  scale: 3
    t.decimal  "idade_superior", precision: 6,  scale: 3
    t.decimal  "valor_inferior", precision: 10, scale: 2
    t.decimal  "valor_superior", precision: 10, scale: 2
    t.integer  "exam_id",                                                null: false
    t.integer  "reference_id"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.boolean  "valido",                                  default: true, null: false
  end

  create_table "weights", force: :cascade do |t|
    t.datetime "date",                               null: false
    t.decimal  "value",      precision: 5, scale: 2, null: false
    t.decimal  "height",     precision: 3, scale: 2, null: false
    t.integer  "user_id",                            null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["date", "user_id"], name: "index_weights_on_date_and_user_id", unique: true, using: :btree
  end

  add_foreign_key "exams", "exams", column: "parent_id"
  add_foreign_key "exams", "units"
  add_foreign_key "exams_results", "exams"
  add_foreign_key "exams_results", "results"
  add_foreign_key "results", "users"
  add_foreign_key "valores", "\"references\"", column: "reference_id"
  add_foreign_key "valores", "exams"
  add_foreign_key "weights", "users"
end
