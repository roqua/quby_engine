class MigrateSettingsToMongo < ActiveRecord::Migration
  class OldSettings < ActiveRecord::Base
    set_table_name :settings

    def value
      YAML::load(self[:value])
    end
  end

  def up
    OldSettings.all.each do |old_setting|
      key = old_setting.var
      val = old_setting.value
      puts "Setting #{key} to #{val.inspect}"
      Settings.send("#{key}=", val)
    end
  end

  def down
  end
end
