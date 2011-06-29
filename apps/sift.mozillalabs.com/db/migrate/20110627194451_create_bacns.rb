class CreateBacns < ActiveRecord::Migration
  def self.up
    create_table :bacns do |t|
      t.integer :user_id
      t.timestamps
    end
    
    add_index :bacns, :user_id
  end

  def self.down
    drop_table :bacns
  end
end
