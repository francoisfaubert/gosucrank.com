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

ActiveRecord::Schema.define(version: 20150130144300) do

  create_table "tweets", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.string   "twitter_post_id"
    t.datetime "created_at"
    t.string   "modified_at"
    t.string   "timestamps"
    t.datetime "updated_at"
  end

  create_table "twitch_streams", force: true do |t|
    t.boolean  "is_live"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtubes", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "youtube_id"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "yturl"
  end

end
