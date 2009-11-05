class Questionnaire < ActiveRecord::Base
  cattr_accessor :key
  cattr_accessor :questions
 
  serialize :value

  set_table_name "questionnaires"

  def to_json
    # TODO
  end
  
  def self.questions
    @questions
  end
  
end
