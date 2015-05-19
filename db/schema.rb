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

ActiveRecord::Schema.define(version: 20150514002558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_messages", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["property_id"], name: "index_favorites_on_property_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

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

  add_index "gamings", ["game_id"], name: "index_gamings_on_game_id", using: :btree
  add_index "gamings", ["property_id"], name: "index_gamings_on_property_id", using: :btree

  create_table "message_replies", force: true do |t|
    t.integer  "user_id"
    t.integer  "sent_message_id"
    t.text     "body"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_replies", ["sent_message_id"], name: "index_message_replies_on_sent_message_id", using: :btree
  add_index "message_replies", ["user_id"], name: "index_message_replies_on_user_id", using: :btree

  create_table "payment_notifications", force: true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.integer  "reservation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_notifications", ["reservation_id"], name: "index_payment_notifications_on_reservation_id", using: :btree

  create_table "properties", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "hunttype"
    t.string   "location"
    t.integer  "price"
    t.boolean  "available",    default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accommodates"
    t.boolean  "per_person",   default: true
    t.string   "phone"
  end

  add_index "properties", ["location"], name: "index_properties_on_location", unique: true, using: :btree
  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "property_attachments", force: true do |t|
    t.integer  "property_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_primary"
  end

  add_index "property_attachments", ["property_id"], name: "index_property_attachments_on_property_id", using: :btree

  create_table "reservations", force: true do |t|
    t.date     "to"
    t.date     "from"
    t.string   "status",        default: "Pending"
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cancel_reason"
    t.integer  "guests",        default: 1
  end

  add_index "reservations", ["property_id"], name: "index_reservations_on_property_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "sent_messages", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "replied_to",        default: false
    t.boolean  "read_by_user"
    t.boolean  "read_by_recipient"
    t.datetime "reply_date"
  end

  add_index "sent_messages", ["user_id"], name: "index_sent_messages_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
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
    t.boolean  "accepted_terms",         default: false
    t.string   "role",                   default: "user"
    t.boolean  "owner",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
