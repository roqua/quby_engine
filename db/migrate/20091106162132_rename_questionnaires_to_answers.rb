class RenameQuestionnairesToAnswers < ActiveRecord::Migration
  def self.up
    rename_table :questionnaires, :answers
  end

  def self.down
    rename_table :answers, :questionnaires
  end
end
