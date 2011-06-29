class CreateHeaders < ActiveRecord::Migration
  def self.up
    create_table :headers do |t|
      t.integer :bacn_id
      t.string  :key
      t.string  :value
    end
    
    add_index :headers, :bacn_id
  end

  def self.down
    drop_table :headers
  end
end
