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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120223061010) do

  create_table "accounts", :force => true do |t|
    t.string  "csp_code"
    t.string  "account_number"
    t.string  "name"
    t.string  "mobile"
    t.string  "district"
    t.string  "bank_name"
    t.string  "bank_branch"
    t.string  "bank_code"
    t.integer "balance"
    t.boolean "status"
    t.integer "created_by"
    t.integer "modified_by"
  end

  create_table "transactions", :force => true do |t|
    t.string  "csp_code"
    t.date    "transaction_date"
    t.integer "amount"
    t.integer "created_by"
    t.integer "modified_by"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.string   "mobile_number"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                   :null => false
    t.string   "perishable_token",  :default => "",   :null => false
    t.integer  "login_count",       :default => 0,    :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.boolean  "status",            :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
