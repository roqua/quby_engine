class RemoveDeprecatedQuestionnaires < ActiveRecord::Migration
  def up
    Questionnaire.find_by_key('wd-extended').andand.destroy
    Questionnaire.find_by_key('accare_ouderversie').andand.destroy
    Questionnaire.find_by_key('accare_algemeen').andand.destroy
    
    Questionnaire.find_by_key('vis-v_2').andand.destroy
    Questionnaire.find_by_key('phamous_02_psychosociaal_3').andand.destroy
    Questionnaire.find_by_key('alg').andand.destroy
    Questionnaire.find_by_key('phamous_02_psychosociaal_2').andand.destroy
    Questionnaire.find_by_key('phamous_algemeen').andand.destroy
    
  end

  def down
  end
end
