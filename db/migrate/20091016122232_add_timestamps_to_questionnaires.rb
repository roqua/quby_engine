class AddTimestampsToQuestionnaires < ActiveRecord::Migration
  def self.up
    add_column("questionnaires", "created_at", :datetime)
    add_column("questionnaires", "updated_at", :datetime)

    q = Questionnaire.all
    q.each do |q|
      q.created_at = Time.now
      q.updated_at = Time.now
      q.save
    end
  end

  def self.down
    remove_column("questionnaires", "created_at")
    remove_column("questionnaires", "updated_at")
  end
end
