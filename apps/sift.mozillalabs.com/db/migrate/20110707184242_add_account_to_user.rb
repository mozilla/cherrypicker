class AddAccountToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :account, :string
    add_index :users, :account
  end

  def self.down
    remove_column :users, :account
  end
end
