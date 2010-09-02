class AddTestBooleanToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :test, :boolean
  end

  def self.down
    remove_column :answers, :test
  end
end
