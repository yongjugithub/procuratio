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

ActiveRecord::Schema.define(version: 2020_03_29_012502) do

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "ride_at"
    t.text "ride_in"
    t.boolean "attr_one"
    t.boolean "attr_two"
    t.boolean "attr_three"
    t.boolean "attr_four"
    t.boolean "attr_five"
    t.boolean "attr_six"
    t.boolean "attr_seven"
    t.boolean "attr_eight"
    t.boolean "attr_nine"
    t.boolean "attr_ten"
    t.boolean "attr_eleven"
    t.boolean "attr_twelve"
    t.text "memo"
    t.integer "point"
    t.bigint "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id", "created_at"], name: "index_attendances_on_employee_id_and_created_at"
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "name", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["employee_id"], name: "index_employees_on_employee_id", unique: true
  end

  add_foreign_key "attendances", "employees"
end
