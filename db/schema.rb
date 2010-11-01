# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101101001129) do

  create_table "aktions", :force => true do |t|
    t.integer  "goal_id"
    t.string   "what"
    t.string   "how"
    t.string   "why"
    t.string   "where"
    t.integer  "who_id"
    t.date     "begins_on"
    t.date     "ends_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_number"
  end

  create_table "consumer_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumer_tokens", ["token"], :name => "index_consumer_tokens_on_token", :unique => true

  create_table "date_tables", :force => true do |t|
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.boolean  "first_day_of_month"
    t.boolean  "last_day_of_month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "federations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followups", :force => true do |t|
    t.integer  "value"
    t.date     "valid_on"
    t.integer  "goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.integer  "goal_id"
    t.string   "objective"
    t.integer  "value"
    t.string   "control_item"
    t.integer  "responsable_id"
    t.date     "due_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_number"
    t.integer  "incidence"
    t.integer  "institution_id"
  end

  create_table "institutions", :force => true do |t|
    t.integer  "padma_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institution_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "drc_user"
    t.integer  "institution_id"
    t.string   "locale"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "authorized"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

end
