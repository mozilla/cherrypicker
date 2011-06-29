class RenameACoupleThings < ActiveRecord::Migration
  def self.up
    rename_column :mime_parts, :data, :body
    rename_column :headers, :key, :name
  end

  def self.down
    rename_column :mime_parts, :body, :data
    rename_column :headers, :name, :key
  end
end
