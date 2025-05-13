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

ActiveRecord::Schema[7.1].define(version: 2025_03_22_063831) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_consultants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "branch_Name"
    t.string "owner_Name"
    t.string "phone_Number"
    t.string "email"
    t.string "gender"
    t.string "location"
    t.text "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admin_consultants_on_user_id"
  end

  create_table "assign_student_labs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.bigint "course_lab_id"
    t.bigint "course_sub_lab_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "version"
    t.string "status"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assign_student_labs_on_course_id"
    t.index ["course_lab_id"], name: "index_assign_student_labs_on_course_lab_id"
    t.index ["course_sub_lab_id"], name: "index_assign_student_labs_on_course_sub_lab_id"
    t.index ["user_id"], name: "index_assign_student_labs_on_user_id"
  end

  create_table "consultant_admins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "address"
    t.integer "branch_admin_id"
    t.bigint "admin_consultant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_consultant_id"], name: "index_consultant_admins_on_admin_consultant_id"
  end

  create_table "course_entrolls", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_entrolls_on_course_id"
    t.index ["user_id"], name: "index_course_entrolls_on_user_id"
  end

  create_table "course_labs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "course_id"
    t.integer "language_id"
    t.boolean "show_login"
    t.text "description"
    t.integer "lab_point"
    t.string "difficulty_level"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_labs_on_course_id"
  end

  create_table "course_sub_labs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "course_lab_id"
    t.text "sub_lab_data"
    t.text "sub_lab_initial_code"
    t.text "correct_option"
    t.text "embedded_url"
    t.string "lab_type"
    t.boolean "show_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_lab_id"], name: "index_course_sub_labs_on_course_lab_id"
  end

  create_table "course_tittles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "sector_id"
    t.boolean "show_login"
    t.json "select_course"
    t.integer "belongs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sector_id"], name: "index_course_tittles_on_sector_id"
  end

  create_table "courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "sector_id"
    t.integer "language_id"
    t.boolean "show_login"
    t.integer "belongs"
    t.string "QuickRefUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sector_id"], name: "index_courses_on_sector_id"
  end

  create_table "demo_tables", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sectors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "show_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_course_entrollments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.string "status"
    t.integer "percentage"
    t.boolean "unlock", default: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_course_entrollments_on_course_id"
    t.index ["user_id"], name: "index_student_course_entrollments_on_user_id"
  end

  create_table "student_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.datetime "dob"
    t.string "phone_number"
    t.string "location"
    t.json "course_details"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_student_details_on_user_id"
  end

  create_table "student_lab_codes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.bigint "course_lab_id"
    t.bigint "course_sub_lab_id"
    t.bigint "assign_student_lab_id"
    t.string "lab_type"
    t.integer "language_id"
    t.text "code_data"
    t.text "output_data"
    t.string "version"
    t.string "take_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assign_student_lab_id"], name: "index_student_lab_codes_on_assign_student_lab_id"
    t.index ["course_id"], name: "index_student_lab_codes_on_course_id"
    t.index ["course_lab_id"], name: "index_student_lab_codes_on_course_lab_id"
    t.index ["course_sub_lab_id"], name: "index_student_lab_codes_on_course_sub_lab_id"
    t.index ["user_id"], name: "index_student_lab_codes_on_user_id"
  end

  create_table "student_lab_entrollments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.bigint "course_lab_id"
    t.string "status"
    t.integer "percentage"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_lab_entrollments_on_course_id"
    t.index ["course_lab_id"], name: "index_student_lab_entrollments_on_course_lab_id"
    t.index ["user_id"], name: "index_student_lab_entrollments_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "username"
    t.integer "belongs_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
