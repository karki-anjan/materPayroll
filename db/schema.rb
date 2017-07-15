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

ActiveRecord::Schema.define(version: 20170710064656) do

  create_table "allowances", force: :cascade do |t|
    t.string   "description"
    t.decimal  "amount",      precision: 9, scale: 2
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["user_id", "created_at"], name: "index_allowances_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_allowances_on_user_id"
  end

  create_table "dope_adjustments", force: :cascade do |t|
    t.string   "description"
    t.decimal  "amount"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id", "created_at"], name: "index_dope_adjustments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_dope_adjustments_on_user_id"
  end

  create_table "nope_adjustments", force: :cascade do |t|
    t.string   "description"
    t.decimal  "amount"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id", "created_at"], name: "index_nope_adjustments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_nope_adjustments_on_user_id"
  end

  create_table "payrolls", force: :cascade do |t|
    t.date     "start_period"
    t.date     "end_period"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["created_at"], name: "index_payrolls_on_created_at"
  end

  create_table "payslips", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "payroll_id"
    t.decimal  "base_salary",         precision: 10, scale: 2
    t.decimal  "sss",                 precision: 6,  scale: 2
    t.decimal  "pagibig",             precision: 6,  scale: 2
    t.decimal  "philhealth",          precision: 6,  scale: 2
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.boolean  "paid",                                         default: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["employee_id"], name: "index_payslips_on_employee_id"
    t.index ["payroll_id"], name: "index_payslips_on_payroll_id"
  end

  create_table "reimbursements", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.decimal  "amount",              precision: 9, scale: 2
    t.decimal  "price",               precision: 9, scale: 2
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id", "created_at"], name: "index_reimbursements_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_reimbursements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.date     "birthday"
    t.date     "date_hired"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "password_digest"
    t.boolean  "admin",            default: false
    t.string   "name"
    t.string   "contact_no"
    t.string   "account_no"
    t.string   "bank"
    t.integer  "base_salary"
    t.integer  "no_of_dependents"
    t.string   "address"
    t.string   "sss_no"
    t.string   "tin_no"
    t.string   "pagibig_no"
    t.string   "philhealth_no"
    t.string   "position"
    t.string   "job"
    t.string   "status"
    t.string   "profileimg"
  end

end
