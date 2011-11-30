class SetQuestionnaireKeysForAnswers < ActiveRecord::Migration
  def up
    coll = Answer.db.collection("answers")

    Questionnaire.all.each do |questionnaire|
      print "#{questionnaire.key}, "
      # Using raw db connection and Mongo commands for speed
      result = coll.update({"questionnaire_id" => questionnaire.id},               # where clause
                           {"$set" => {"questionnaire_key" => questionnaire.key}}, # changes to make
                           :multi => true, :safe => true)                          # options
      raise "Error #{result.inspect}" if result["err"]
    end
    print "\n"
  end

  def down
  end
end
