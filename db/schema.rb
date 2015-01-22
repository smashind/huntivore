# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150121113558) do

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["property_id"], name: "index_favorites_on_property_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamings", force: true do |t|
    t.integer  "game_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gamings", ["game_id"], name: "index_gamings_on_game_id"
  add_index "gamings", ["property_id"], name: "index_gamings_on_property_id"

  create_table "payment_notifications", force: true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.integer  "reservation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_notifications", ["reservation_id"], name: "index_payment_notifications_on_reservation_id"

  create_table "properties", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "hunttype"
    t.string   "location"
    t.integer  "price"
    t.boolean  "available"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accommodates"
  end

  add_index "properties", ["location"], name: "index_properties_on_location", unique: true
  add_index "properties", ["user_id"], name: "index_properties_on_user_id"

  create_table "property_attachments", force: true do |t|
    t.integer  "property_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_attachments", ["property_id"], name: "index_property_attachments_on_property_id"

  create_table "reservations", force: true do |t|
    t.date     "to"
    t.date     "from"
    t.string   "status",        default: "Pending"
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cancel_reason"
  end

  add_index "reservations", ["property_id"], name: "index_reservations_on_property_id"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "website"
    t.string   "instagram"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
