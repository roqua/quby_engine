class CreateQuestionnaires < ActiveRecord::Migration
  def self.up
    create_table "questionnaires" do |t|
      t.string :key
      t.text   :definition
      t.timestamps
    end
  end

  def self.down
    drop_table "questionnaires"
  end
end
