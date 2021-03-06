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

ActiveRecord::Schema.define(version: 2019_03_22_052017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "production_company_id"
    t.index ["production_company_id"], name: "index_cities_on_production_company_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "production_company_id"
    t.bigint "film_id"
    t.index ["film_id"], name: "index_countries_on_film_id"
    t.index ["production_company_id"], name: "index_countries_on_production_company_id"
  end

  create_table "films", force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.string "release_month"
    t.integer "release_year"
    t.string "imdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "imdb_id"
    t.string "name"
    t.boolean "director", default: false
    t.boolean "diva", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "film_id"
    t.index ["film_id"], name: "index_people_on_film_id"
  end

  create_table "production_companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "film_id"
    t.index ["film_id"], name: "index_production_companies_on_film_id"
  end

  add_foreign_key "cities", "production_companies"
  add_foreign_key "countries", "films"
  add_foreign_key "countries", "production_companies"
  add_foreign_key "people", "films"
  add_foreign_key "production_companies", "films"
end
