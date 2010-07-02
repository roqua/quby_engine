class RemoveDefinitionColumnFromQuestionnaires < ActiveRecord::Migration
  def self.up
    remove_column :questionnaires, :definition
    remove_column :questionnaires, :description
    remove_column :questionnaires, :title
  end

  def self.down
  end
end
