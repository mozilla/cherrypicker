class AddBacnIdToMimeParts < ActiveRecord::Migration
  def self.up
    # How did this get missed anyway?
    add_column :mime_parts, :bacn_id, :integer
    add_index :mime_parts, :bacn_id
  end

  def self.down
    remove_column :mime_parts, :bacn_id
  end
end
