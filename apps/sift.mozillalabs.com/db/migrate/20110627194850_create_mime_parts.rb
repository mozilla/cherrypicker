class CreateMimeParts < ActiveRecord::Migration
  def self.up
    create_table :mime_parts do |t|
      t.string :content_type
      t.column :data, :longtext
    end
    
    add_index :mime_parts, :content_type
  end

  def self.down
    drop_table :mime_parts
  end
end
