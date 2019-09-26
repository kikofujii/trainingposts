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

ActiveRecord::Schema.define(version: 2019_09_17_111417) do

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trainingpost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trainingpost_id"], name: "index_favorites_on_trainingpost_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "posts_imgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "url"
    t.bigint "trainingpost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trainingpost_id"], name: "index_posts_imgs_on_trainingpost_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "trainingposts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.string "training_part"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "post_img"
    t.index ["user_id"], name: "index_trainingposts_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "icon_img"
    t.string "introduce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "continuos_count", default: 0
  end

  add_foreign_key "favorites", "trainingposts"
  add_foreign_key "favorites", "users"
  add_foreign_key "posts_imgs", "trainingposts"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "trainingposts", "users"
end
