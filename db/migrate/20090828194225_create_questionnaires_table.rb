class CreateQuestionnairesTable < ActiveRecord::Migration
  def self.up
    create_table "questionnaires" do |t|
      t.string :key
      t.text   :value
    end
  end

  def self.down
    remove_table "questionnaires"
  end
end
