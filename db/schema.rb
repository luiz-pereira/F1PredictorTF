# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_03_022739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "circuits", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "continent"
    t.integer "num_races"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "num_races"
    t.integer "current_team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number"
    t.integer "races"
    t.integer "poles"
    t.integer "wins"
    t.integer "podiums"
    t.integer "fastest_laps"
    t.integer "championships"
  end

  create_table "engines", force: :cascade do |t|
    t.string "engine"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "races", force: :cascade do |t|
    t.integer "circuit_id"
    t.string "weather"
    t.date "race_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer "driver_id"
    t.integer "race_id"
    t.integer "position_start"
    t.integer "position_finish"
    t.time "best_lap"
    t.time "total_time"
    t.integer "team_id"
    t.integer "engine_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "current_engine"
    t.integer "num_races"
    t.decimal "budget"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "races"
    t.integer "poles"
    t.integer "wins"
    t.integer "podiums"
    t.integer "fastest_laps"
    t.integer "driver_championships"
    t.integer "team_championships"
  end

end
