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

ActiveRecord::Schema.define(version: 2022_01_13_111758) do

  create_table "authors", force: :cascade do |t|
    t.string "author_name"
    t.date "date_birth"
    t.date "date_death"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book_authorships", force: :cascade do |t|
    t.integer "book_id"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "books", force: :cascade do |t|
    t.bigint "category_id"
    t.string "book_title"
    t.string "isbn"
    t.date "year_published"
    t.string "description"
    t.integer "quantity"
    t.string "publishing_house"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loaned_books", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "date_loaned"
    t.datetime "date_due"
    t.datetime "date_returned"
    t.float "overdue_fee"
    t.integer "status", default: 0
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loaned_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "loaned_book_id"
  create_table "loaned_details", force: :cascade do |t|
    t.integer "loaned_id"
    t.bigint "book_id"
    t.integer "quantity"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "fk_rails_3132f14d22"
    t.index ["loaned_book_id"], name: "fk_rails_e39b9f5c48"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 2
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "phone_number"
    t.string "password"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "book_authorships", "authors"
  add_foreign_key "book_authorships", "books"
  add_foreign_key "books", "categories"
  add_foreign_key "loaned_books", "users"
  add_foreign_key "loaned_books", "users"
  add_foreign_key "loaned_details", "books"
  add_foreign_key "loaned_details", "loaned_books"
end
