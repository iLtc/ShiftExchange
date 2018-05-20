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

ActiveRecord::Schema.define(version: 20180330170706) do

  create_table "key_values", force: :cascade do |t|
    t.string "key"
    t.string "key_type"
    t.string "value"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "login_credentials", force: :cascade do |t|
    t.string "credential"
    t.string "platform"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_login_credentials_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "shift_users", force: :cascade do |t|
    t.integer "shift_id"
    t.integer "user_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_shift_users_on_shift_id"
    t.index ["user_id"], name: "index_shift_users_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.string "start"
    t.string "end"
    t.string "location"
    t.string "shift_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "period"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "prefer_name"
    t.integer "credits", default: 0
    t.integer "level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
