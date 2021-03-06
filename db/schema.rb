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

ActiveRecord::Schema.define(version: 20140221042117) do

  create_table "recruiters", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "recruiters", ["remember_token"], name: "index_recruiters_on_remember_token"

  create_table "students", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.integer  "year"
    t.string   "school"
    t.string   "discipline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["remember_token"], name: "index_students_on_remember_token"

end
