class MigrateAnswersToMongo < ActiveRecord::Migration
  class OldAnswer < ActiveRecord::Base
    set_table_name "answers"
    serialize :value
  end

  def up
    OldAnswer.find_each do |answer|
      unless @quest_hash[answer.questionnaire_id]
        puts "Skipping #{answer.id}, unknown questionnaire"
      else
        puts "Processing #{answer.id} for #{@quest_hash[answer.questionnaire_id]}"
        Answer.create!(:_id => answer.id,
                       :questionnaire_id => answer.questionnaire_id,
                       :patient_id => answer.patient_id,
                       :active => answer.active,
                       :test => answer.test,
                       :created_at => answer.created_at,
                       :updated_at => answer.updated_at,
                       :value => answer.value,
                       :token => answer.token)
      end
    end
  end

  def down
    Answer.clear
  end
end
