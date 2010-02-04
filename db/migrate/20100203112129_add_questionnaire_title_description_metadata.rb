class AddQuestionnaireTitleDescriptionMetadata < ActiveRecord::Migration
  def self.up
    add_column :questionnaires, :title, :string
    add_column :questionnaires, :description, :text
  end

  def self.down
    remove_column :questionnaires, :title
    remove_column :questionnaires, :description
  end
end
