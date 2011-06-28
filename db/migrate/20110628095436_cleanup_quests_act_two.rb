class CleanupQuestsActTwo < ActiveRecord::Migration
  def self.up
    q = Questionnaire.find_by_key "FSS-III.rb.REMOTE.19889"
    q.destroy if q
    q = Questionnaire.find_by_key "FSS-III.rb.LOCAL.19889"
    q.destroy if q
  end

  def self.down
  end
end
