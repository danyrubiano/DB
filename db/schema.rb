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

ActiveRecord::Schema.define(version: 20150928043102) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "post_id",      limit: 4
    t.text     "body",         limit: 65535
    t.string   "anonimo",      limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "tipo_usuario", limit: 4
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "titulo",             limit: 255
    t.text     "descripcion",        limit: 65535
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id",            limit: 4
    t.integer  "visits_count",       limit: 4
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.integer  "total_comments",     limit: 4,     default: 0
    t.integer  "num_calificaciones", limit: 4,     default: 0
    t.integer  "calificacion_total", limit: 4,     default: 0
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                    limit: 255, default: "",       null: false
    t.string   "encrypted_password",       limit: 255, default: "",       null: false
    t.string   "reset_password_token",     limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            limit: 4,   default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",       limit: 255
    t.string   "last_sign_in_ip",          limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "name",                     limit: 255
    t.integer  "permission_level",         limit: 4,   default: 1
    t.integer  "post_diarios",             limit: 4,   default: 0
    t.string   "name_user",                limit: 255
    t.string   "last_name",                limit: 255
    t.date     "fecha_nacimiento"
    t.string   "state",                    limit: 255, default: "activo"
    t.string   "foto_perfil_file_name",    limit: 255
    t.string   "foto_perfil_content_type", limit: 255
    t.integer  "foto_perfil_file_size",    limit: 4
    t.datetime "foto_perfil_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "valorations", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "post_id",      limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "calificacion", limit: 4, default: 0
  end

  add_index "valorations", ["post_id"], name: "index_valorations_on_post_id", using: :btree
  add_index "valorations", ["user_id"], name: "index_valorations_on_user_id", using: :btree

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "valorations", "posts"
  add_foreign_key "valorations", "users"
end
