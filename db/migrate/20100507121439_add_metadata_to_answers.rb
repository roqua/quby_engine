class AddMetadataToAnswers < ActiveRecord::Migration
  def self.up
    add_column(:answers, :token, :string)
  end

  def self.down
    remove_column(:answers, :token)
  end
end
