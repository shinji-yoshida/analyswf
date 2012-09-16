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

ActiveRecord::Schema.define(:version => 20120916110007) do

  create_table "offsets", :force => true do |t|
    t.integer  "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "swf_id"
    t.string   "offset_type"
  end

  add_index "offsets", ["swf_id"], :name => "index_offsets_on_swf_id"

  create_table "swf_binaries", :force => true do |t|
    t.binary   "data"
    t.integer  "swf_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "swf_binaries", ["swf_id"], :name => "index_swf_binaries_on_swf_id"

  create_table "swf_series", :force => true do |t|
    t.string   "name"
    t.integer  "version"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "swf_series", ["name"], :name => "index_swf_series_on_name"

  create_table "swfs", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "swf_series_id"
    t.integer  "swf_binary_id"
  end

end
