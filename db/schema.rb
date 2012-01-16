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

ActiveRecord::Schema.define(:version => 20120116165047) do

  create_table "airbrake_errors", :force => true do |t|
    t.integer  "airbrake_project_id",                    :null => false
    t.integer  "group_id",                               :null => false
    t.integer  "notice_id",                              :null => false
    t.text     "error_message"
    t.boolean  "resolved",            :default => false
    t.datetime "occurred_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "airbrake_errors", ["airbrake_project_id"], :name => "index_airbrake_errors_on_airbrake_project_id"
  add_index "airbrake_errors", ["group_id"], :name => "index_airbrake_errors_on_group_id"
  add_index "airbrake_errors", ["notice_id"], :name => "index_airbrake_errors_on_notice_id"

  create_table "airbrake_projects", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.integer  "airbrake_id"
    t.string   "api_key"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "iframes", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "url"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "iframes", ["project_id"], :name => "index_iframes_on_project_id"
  add_index "iframes", ["slug"], :name => "index_iframes_on_slug"

  create_table "projects", :force => true do |t|
    t.string   "project"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "projects", ["slug"], :name => "index_projects_on_slug"

end
