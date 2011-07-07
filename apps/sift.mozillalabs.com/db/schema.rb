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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110707184242) do

  create_table "bacns", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

  add_index "bacns", ["source"], :name => "index_bacns_on_source"
  add_index "bacns", ["user_id"], :name => "index_bacns_on_user_id"

  create_table "headers", :force => true do |t|
    t.integer "bacn_id"
    t.string  "name"
    t.string  "value"
  end

  add_index "headers", ["bacn_id"], :name => "index_headers_on_bacn_id"

  create_table "mime_parts", :force => true do |t|
    t.string  "content_type"
    t.text    "body",         :limit => 2147483647
    t.integer "bacn_id"
  end

  add_index "mime_parts", ["bacn_id"], :name => "index_mime_parts_on_bacn_id"
  add_index "mime_parts", ["content_type"], :name => "index_mime_parts_on_content_type"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account"
  end

  add_index "users", ["account"], :name => "index_users_on_account"
  add_index "users", ["email"], :name => "index_users_on_email"

end
