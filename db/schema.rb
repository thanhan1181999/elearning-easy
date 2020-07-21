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

ActiveRecord::Schema.define(version: 2020_07_21_171300) do

  create_table "course_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.integer "course_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.index ["course_category_id"], name: "index_courses_on_course_category_id"
    t.index ["user_id", "course_category_id", "created_at"], name: "index_courses_on_user_id_and_course_category_id_and_created_at"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_follows_on_course_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "joins", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_joins_on_course_id"
    t.index ["user_id", "course_id", "created_at"], name: "index_joins_on_user_id_and_course_id_and_created_at"
    t.index ["user_id"], name: "index_joins_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "created_at"], name: "index_lessons_on_course_id_and_created_at"
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "lessons_words", id: false, force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.integer "word_id", null: false
    t.index ["lesson_id", "word_id"], name: "index_lessons_words_on_lesson_id_and_word_id"
    t.index ["word_id", "lesson_id"], name: "index_lessons_words_on_word_id_and_lesson_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "studies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "word_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_studies_on_user_id"
    t.index ["word_id"], name: "index_studies_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "remember_digest"
    t.string "picture"
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.string "meaning"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "courses", "course_categories"
  add_foreign_key "courses", "users"
  add_foreign_key "follows", "courses"
  add_foreign_key "follows", "users"
  add_foreign_key "joins", "courses"
  add_foreign_key "joins", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "studies", "users"
  add_foreign_key "studies", "words"
end
