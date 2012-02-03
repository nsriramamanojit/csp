class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string  :csp_code
      t.string  :account_number
      t.string  :name
      t.string  :mobile
      t.string  :district
      t.string  :bank_name
      t.string  :bank_branch
      t.string  :bank_code
      t.integer :balance
      t.boolean :status

      t.integer :created_by
      t.integer :modified_by

    end
  end

  def self.down
    drop_table :accounts
  end
end
