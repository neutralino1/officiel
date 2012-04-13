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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120413151553) do

  create_table "actions", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "user_id",    :null => false
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actions", ["page_id"], :name => "index_actions_on_page_id"
  add_index "actions", ["user_id"], :name => "index_actions_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "home"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "pages", ["owner_id"], :name => "index_pages_on_owner_id"

  create_table "permissions", :force => true do |t|
    t.integer  "page_id"
    t.string   "rights",      :default => "read", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "entity_type"
  end

  add_index "permissions", ["entity_id", "entity_type", "page_id"], :name => "index_permissions_on_entity_id_and_entity_type_and_page_id", :unique => true
  add_index "permissions", ["entity_id", "entity_type"], :name => "index_permissions_on_entity_id_and_entity_type"
  add_index "permissions", ["page_id"], :name => "index_permissions_on_page_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_users", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams_users", ["team_id", "user_id"], :name => "index_teams_users_on_team_id_and_user_id", :unique => true
  add_index "teams_users", ["team_id"], :name => "index_teams_users_on_team_id"
  add_index "teams_users", ["user_id"], :name => "index_teams_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "status"
    t.string   "position"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "skype"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "version"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["page_id"], :name => "index_versions_on_page_id"

end
