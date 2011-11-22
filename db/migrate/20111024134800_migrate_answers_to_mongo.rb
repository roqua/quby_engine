class MigrateAnswersToMongo < ActiveRecord::Migration
  class OldAnswer < ActiveRecord::Base
    set_table_name "answers"
    serialize :value
  end

  class Answer
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :answers

    identity type: String
    field :questionnaire_id,  :type => Integer
    field :value,             :type => Hash
    field :patient_id,        :type => String
    field :token,             :type => String
    field :active,            :type => Boolean, :default => true
    field :test,              :type => Boolean, :default => false
  end

  def up
    STDOUT.sync = true
    questionnaires = Questionnaire.all
    questionnaires.each do |questionnaire|
      puts "Processing answers for #{questionnaire.key}"
      OldAnswer.where(:questionnaire_id => questionnaire.id).find_each do |answer|
        Answer.safely.create!(:_id => answer.id,
                              :questionnaire_id => answer.questionnaire_id,
                              :patient_id => answer.patient_id,
                              :active => answer.active,
                              :test => answer.test,
                              :created_at => answer.created_at,
                              :updated_at => answer.updated_at,
                              :value => answer.value,
                              :token => answer.token)
        print '.'
      end
      puts ' done'
    end
    raise "Sanity check failed" unless OldAnswer.count == Answer.count
  end

  def down
    Answer.delete_all
  end
end
