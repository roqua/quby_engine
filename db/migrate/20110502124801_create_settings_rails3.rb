class CreateSettingsRails3 < ActiveRecord::Migration
  def self.up
    rename_column :settings, :thing_id, :target_id
    rename_column :settings, :thing_type, :target_type
  end

  def self.down
  end
end
