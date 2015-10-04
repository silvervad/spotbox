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

ActiveRecord::Schema.define(version: 20150919093710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "continents", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.integer  "continent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "countries", ["continent_id"], name: "index_countries_on_continent_id", using: :btree
  add_index "countries", ["slug"], name: "index_countries_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "photos", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "regions", ["country_id"], name: "index_regions_on_country_id", using: :btree
  add_index "regions", ["name"], name: "index_regions_on_name", unique: true, using: :btree
  add_index "regions", ["slug"], name: "index_regions_on_slug", unique: true, using: :btree

  create_table "schools", force: true do |t|
    t.integer  "spot_id"
    t.integer  "sports"
    t.string   "name"
    t.decimal  "latitude",    precision: 10, scale: 6
    t.decimal  "longitude",   precision: 10, scale: 6
    t.string   "link"
    t.integer  "affiliation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["name"], name: "index_schools_on_name", using: :btree
  add_index "schools", ["spot_id"], name: "index_schools_on_spot_id", using: :btree

  create_table "seasons", force: true do |t|
    t.integer  "spot_id"
    t.integer  "sport_id"
    t.string   "months",     limit: 12
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "seasons", ["sport_id"], name: "index_seasons_on_sport_id", using: :btree
  add_index "seasons", ["spot_id", "sport_id"], name: "index_seasons_on_spot_id_and_sport_id", using: :btree
  add_index "seasons", ["spot_id"], name: "index_seasons_on_spot_id", using: :btree

  create_table "sports", force: true do |t|
    t.string "name"
  end

  create_table "spots", force: true do |t|
    t.string   "name"
    t.decimal  "latitude",   precision: 10, scale: 6
    t.decimal  "longitude",  precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.string   "slug"
    t.integer  "region_id"
  end

  add_index "spots", ["country_id"], name: "index_spots_on_country_id", using: :btree
  add_index "spots", ["name"], name: "index_spots_on_name", using: :btree
  add_index "spots", ["region_id"], name: "index_spots_on_region_id", using: :btree
  add_index "spots", ["slug"], name: "index_spots_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
