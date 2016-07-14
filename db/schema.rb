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

ActiveRecord::Schema.define(version: 20160712230200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 510
    t.string   "email",      limit: 510, null: false
    t.text     "message",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", force: :cascade do |t|
    t.string   "name",       limit: 510, null: false
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.index ["name", "parent_id", "unit_id"], name: "exames_nome_parent_id_unidade_id_key", unique: true, using: :btree
    t.index ["parent_id"], name: "exames_parent_id_idx", using: :btree
    t.index ["unit_id"], name: "exames_unidade_id_idx", using: :btree
  end

  create_table "exams_results", force: :cascade do |t|
    t.decimal  "value",      precision: 10, scale: 2, null: false
    t.integer  "exam_id",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "result_id",                           null: false
    t.index ["exam_id", "result_id"], name: "exames_resultados_exame_id_resultado_id_key", unique: true, using: :btree
    t.index ["exam_id"], name: "exames_resultados_exame_id_idx", using: :btree
    t.index ["result_id"], name: "exames_resultados_resultado_id_idx", using: :btree
  end

  create_table "references", force: :cascade do |t|
    t.string   "name",       limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "referencias_nome_key", unique: true, using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.date     "date",                    null: false
    t.string   "description", limit: 510, null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["date", "description", "user_id"], name: "resultados_data_descricao_user_id_key", unique: true, using: :btree
    t.index ["user_id"], name: "resultados_user_id_idx", using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name",       limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "unidades_nome_key", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 510, default: "",    null: false
    t.string   "reset_password_token",   limit: 510
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "confirmation_token",     limit: 510
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 510
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 510
    t.datetime "locked_at"
    t.string   "authentication_token",   limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 510,                 null: false
    t.string   "gender",                 limit: 510,                 null: false
    t.date     "date_of_birth",                                      null: false
    t.boolean  "admin",                              default: false, null: false
    t.string   "password_digest",                    default: "",    null: false
    t.index ["authentication_token"], name: "users_authentication_token_key", unique: true, using: :btree
    t.index ["confirmation_token"], name: "users_confirmation_token_key", unique: true, using: :btree
    t.index ["email"], name: "users_email_key", unique: true, using: :btree
    t.index ["reset_password_token"], name: "users_reset_password_token_key", unique: true, using: :btree
    t.index ["unlock_token"], name: "users_unlock_token_key", unique: true, using: :btree
  end

  create_table "valores", force: :cascade do |t|
    t.string   "gender",         limit: 510
    t.decimal  "idade_inferior",             precision: 6,  scale: 3
    t.decimal  "idade_superior",             precision: 6,  scale: 3
    t.decimal  "valor_inferior",             precision: 10, scale: 2
    t.decimal  "valor_superior",             precision: 10, scale: 2
    t.integer  "exam_id",                                                            null: false
    t.integer  "reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "valid",                                               default: true, null: false
    t.index ["exam_id"], name: "valores_exame_id_idx", using: :btree
    t.index ["reference_id"], name: "valores_referencia_id_idx", using: :btree
  end

  create_table "weights", force: :cascade do |t|
    t.datetime "date",                               null: false
    t.decimal  "value",      precision: 5, scale: 2, null: false
    t.decimal  "height",     precision: 3, scale: 2, null: false
    t.integer  "user_id",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "pesos_user_id_idx", using: :btree
  end

  add_foreign_key "exams", "exams", column: "parent_id"
  add_foreign_key "exams", "units", name: "exames_unidade_id_fk"
  add_foreign_key "exams_results", "exams"
  add_foreign_key "exams_results", "results"
  add_foreign_key "results", "users"
  add_foreign_key "valores", "\"references\"", column: "reference_id", name: "valores_referencia_id_fk"
  add_foreign_key "valores", "exams", name: "valores_exame_id_fk"
  add_foreign_key "weights", "users", name: "pesos_user_id_fk"
end
