class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string  :csp_code, :null=>false
      t.string  :account_number, :default=>"N.A"
      t.string  :name,:default=>"N.A"
      t.string  :mobile,:default=>"N.A"
      t.string  :district,:default=>"N.A"
      t.string  :bank_name,:default=>"N.A"
      t.string  :bank_branch,:default=>"N.A"
      t.string  :bank_code,:default=>"N.A"
      t.integer :balance,:default=>0
      t.boolean :status,:default=>1

      t.integer :created_by
      t.integer :modified_by

    end
  end

  def self.down
    drop_table :accounts
  end
end
