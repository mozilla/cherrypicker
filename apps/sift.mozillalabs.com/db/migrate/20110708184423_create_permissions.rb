class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string  :source
      t.integer :user_id
      t.string  :value, :default => 'display'
      t.timestamps
    end
    
    add_index :permissions, [:source, :user_id], :unique => true

  end

  def self.down
    drop_table :permissions
  end
end
