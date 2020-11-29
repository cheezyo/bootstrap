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

ActiveRecord::Schema.define(version: 2020_11_29_231107) do

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "type_of_exercise_id"
    t.integer "year"
    t.string "gender"
    t.text "results"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "player_id"
    t.text "feed_back"
    t.date "email_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "coach"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "next_level"
    t.integer "prev_level"
    t.string "url"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "player_id"
    t.string "opponent"
    t.text "comment"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "periodizations", force: :cascade do |t|
    t.integer "week"
    t.text "tennis_focus"
    t.integer "tennis_intesity"
    t.text "physical_focus"
    t.integer "physical_intesity"
    t.integer "planet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planet_coaches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "planet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "title"
    t.string "age"
    t.string "color"
    t.integer "planet_coach_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "diary"
    t.boolean "ironman"
    t.boolean "utr"
    t.boolean "events"
    t.boolean "stats"
    t.boolean "player_access"
    t.boolean "periodization"
    t.boolean "feedback"
  end

  create_table "player_stickers", force: :cascade do |t|
    t.integer "player_id"
    t.integer "sticker_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "player_tournaments", force: :cascade do |t|
    t.integer "player_id"
    t.integer "tournament_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.date "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "gender"
    t.string "lastname"
    t.integer "level_id"
    t.integer "planet_id"
    t.string "utr_profile"
    t.text "utr_stats"
    t.text "utr_matches"
    t.text "utr_matches_array"
    t.boolean "competitor"
    t.text "parent_email"
  end

  create_table "stickers", force: :cascade do |t|
    t.string "name"
    t.integer "level_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "trophy"
  end

  create_table "task_categories", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "task_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task"
    t.integer "task_category_id"
    t.integer "player_id"
    t.boolean "done"
    t.date "done_date"
    t.integer "progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.integer "coach_id"
  end

  create_table "test_groups", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tests", force: :cascade do |t|
    t.float "sprint"
    t.float "spider"
    t.float "jump"
    t.float "fh_throw"
    t.float "bh_throw"
    t.integer "box"
    t.integer "player_id"
    t.integer "test_group_id"
    t.integer "chins"
    t.integer "situps"
    t.integer "pushups"
    t.float "back_stretch"
    t.float "front_stretch"
    t.float "test_score"
    t.float "beep"
    t.string "gender"
    t.string "test_type"
    t.integer "age"
    t.integer "program1"
    t.integer "program2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "test_date"
    t.boolean "count"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.boolean "u11"
    t.boolean "u12"
    t.boolean "u13"
    t.boolean "u14"
    t.boolean "u15"
    t.boolean "u16"
    t.boolean "u19"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "end_date"
    t.boolean "club_trip"
    t.integer "user_id"
    t.boolean "only_coach"
    t.boolean "u10"
    t.boolean "senior"
    t.boolean "u17"
    t.boolean "u18"
    t.boolean "pluss"
    t.text "flight_hotel"
    t.text "commet"
  end

  create_table "training_programs", force: :cascade do |t|
    t.integer "prog_number"
    t.string "prog_url"
    t.string "prog_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.integer "type_of_training_id"
    t.integer "time"
    t.date "t_date"
    t.string "coment_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "rating"
  end

  create_table "type_of_exercises", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "type_of_trainings", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_players", force: :cascade do |t|
    t.integer "user_id"
    t.integer "player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "admin", default: false
    t.boolean "coach", default: false
    t.boolean "parent", default: false
    t.boolean "player"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "utr_reports", force: :cascade do |t|
    t.date "utr_date"
    t.text "boys"
    t.text "girls"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
