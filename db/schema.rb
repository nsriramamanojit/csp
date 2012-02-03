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

ActiveRecord::Schema.define(:version => 20120203053700) do

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

end
