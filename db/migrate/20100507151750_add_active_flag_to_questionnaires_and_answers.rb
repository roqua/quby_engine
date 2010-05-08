class AddActiveFlagToQuestionnairesAndAnswers < ActiveRecord::Migration
  def self.up
    add_column(:questionnaires, :active, :boolean, :default => true)
    add_column(:answers,        :active, :boolean, :default => true) 
  end

  def self.down
    remove_column(:questionnaires, :active)
    remove_column(:answers,        :active)
  end
end
