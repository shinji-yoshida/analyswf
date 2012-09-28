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

ActiveRecord::Schema.define(:version => 20120928113437) do

  create_table "images", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
  end

  add_index "images", ["name"], :name => "index_images_on_name", :unique => true

  create_table "offsets", :force => true do |t|
    t.integer  "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "swf_id"
    t.string   "offset_type"
    t.string   "target_name"
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
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "test_script",  :default => "", :null => false
    t.integer  "swf_title_id"
  end

  add_index "swf_series", ["name"], :name => "index_swf_series_on_name"
  add_index "swf_series", ["swf_title_id"], :name => "index_swf_series_on_swf_title_id"

  create_table "swf_titles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "swfs", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "swf_series_id"
  end

  create_table "test_resources", :force => true do |t|
    t.integer  "swf_series_id"
    t.integer  "image_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "test_resources", ["image_id"], :name => "index_test_resources_on_image_id"
  add_index "test_resources", ["swf_series_id"], :name => "index_test_resources_on_swf_series_id"

end
