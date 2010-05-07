class AddMetadataToAnswers < ActiveRecord::Migration
  def self.up
    add_column(:answers, :token, :string)

    Answer.all.each do |a|
      a.token = ActiveSupport::SecureRandom.hex(8)
      a.save
    end
  end

  def self.down
    remove_column(:answers, :token)
  end
end
