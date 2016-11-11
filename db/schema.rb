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

ActiveRecord::Schema.define(version: 20160218221130) do

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "category"
    t.string   "content"
    t.boolean  "is_published",       default: false
    t.boolean  "friends_and_family", default: false
    t.boolean  "allow_comments",     default: false
    t.string   "top_image"
    t.string   "kind_of"
    t.integer  "views"
    t.string   "urllink"
    t.string   "firstimage"
    t.integer  "user_id"
    t.datetime "published_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "link",               default: ""
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email"
    t.string   "verification_string"
    t.boolean  "verified"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "password_digest"
    t.string   "role"
    t.string   "image"
    t.string   "auth_secret"
    t.boolean  "use_two_factor",       default: false
    t.integer  "login_attempts",       default: 0
    t.boolean  "account_locked",       default: false
    t.text     "password_reset_token"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

end
