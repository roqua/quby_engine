class AddQuestionnaireIdToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :questionnaire_id, :integer
    remove_column :answers, :type
    remove_column :answers, :key
  end

  def self.down
    remove_column :answers, :questionnaire_id
  end
end
