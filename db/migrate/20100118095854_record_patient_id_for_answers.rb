class RecordPatientIdForAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :patient_id, :string
  end

  def self.down
    remove_column :answers, :patient_id
  end
end
