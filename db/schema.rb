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

ActiveRecord::Schema.define(version: 2018_08_15_184445) do

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name", limit: 25
    t.string "last_name", limit: 50
    t.string "email", limit: 100, default: "", null: false
    t.string "username", limit: 25
    t.string "password_digest", limit: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_admin_users_on_username"
  end

  create_table "criteria", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "transition_id", null: false
    t.integer "criteria_type", null: false
    t.string "key", limit: 100
    t.string "value", limit: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transition_id"], name: "index_criteria_on_transition_id"
  end

  create_table "states", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "transitions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "workflow_id", null: false
    t.string "name", limit: 100
    t.integer "from_state_id", null: false
    t.integer "to_state_id", null: false
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_state_id"], name: "index_transitions_on_from_state"
    t.index ["to_state_id"], name: "index_transitions_on_to_state"
    t.index ["workflow_id"], name: "index_transitions_on_workflow_id"
  end

  create_table "workflow_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "initial_state", limit: 100, null: false
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "name", unique: true
  end

end
