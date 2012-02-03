class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string  :csp_code
      t.date    :transaction_date
      t.integer :amount

      t.integer :created_by
      t.integer :modified_by
    end
  end

  def self.down
    drop_table :transactions
  end
end
