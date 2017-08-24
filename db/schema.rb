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

ActiveRecord::Schema.define(version: 20170823105251) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.float "price", limit: 24
    t.string "unit"
    t.integer "in_stock"
    t.json "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "role", default: 1
    t.integer "gender", default: 0
    t.string "avatar"
    t.string "phone"
    t.bigint "manager_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_shop_managers_on_manager_id"
    t.index ["shop_id"], name: "index_shop_managers_on_shop_id"
  end

  create_table "shops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "logo"
    t.string "phone"
    t.string "address"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "phone"
    t.integer "gender", default: 0
    t.string "address"
    t.string "province"
    t.string "zipcode"
    t.string "uid"
    t.string "auth_token"
    t.string "token"
    t.date "confirm_at"
    t.datetime "create_token_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
