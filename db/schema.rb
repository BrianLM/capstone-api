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

ActiveRecord::Schema.define(version: 20171127151044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "examples", force: :cascade do |t|
    t.text     "text",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_examples_on_user_id", using: :btree
  end

  create_table "explorations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "current"
    t.integer  "top_f"
    t.integer  "top_m"
    t.integer  "top_p"
    t.integer  "top_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_explorations_on_user_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
    t.index ["user_id"], name: "index_items_on_user_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "payout"
    t.string   "skill"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id", using: :btree
  end

  create_table "levels", force: :cascade do |t|
    t.integer  "level"
    t.integer  "required"
    t.integer  "energy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "experience"
    t.integer  "level"
    t.integer  "gold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "token",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["token"], name: "index_users_on_token", unique: true, using: :btree
  end

  add_foreign_key "examples", "users"
  add_foreign_key "explorations", "users"
  add_foreign_key "items", "users"
  add_foreign_key "jobs", "users"
  add_foreign_key "user_profiles", "users"
end
