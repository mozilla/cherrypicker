class AddSourceToBacn < ActiveRecord::Migration
  def self.up
    add_column :bacns, :source, :string
    add_index :bacns, :source
  end

  def self.down
    remove_column :bacns, :source
  end
end
