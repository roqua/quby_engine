load File.join(RAILS_ROOT, "lib/quby/init.rb")

Quby::Questionnaires.define :oq45 do

  question :q01, :type => :radio do
    title "Ik kan goed met anderen overweg."
    description "...."
    help ".............."
    after_answer do
      jump_to :q04 if answer < 2
    end
  end

  question :q02, :type => :radio, :title => "Ik word gauw moe."
  question :q03, :type => :radio, :title => "Ik ben nergens in geinteresseerd."
  question :q04, :type => :radio, :title => "Ik sta onder stress op het werk/op school."
  question :q05, :type => :radio, :title => "Ik geef mezelf overal de schuld van."
  question :q06, :type => :radio, :title => "Ik ben geirriteerd."

end


#class Oq45 < Questionnaire
#
#  database_name "http://localhost:5984/quby_development"
#
#  def questions
#    @questions ||= {
#      :q01 => Questionnaires.define_question("Ik kan goed met anderen overweg.",
#                              :type => :radio),
#      :q02 => Questionnaires.define_question("Ik word gauw moe.", 
#                              :type => :radio),
#      :q03 => Questionnaires.define_question("Ik ben nergens in geinteresseerd.",
#                              :type => :radio),
#      :q04 => Questionnaires.define_question("Ik sta onder stress op het werk/op school.",
#                              :type => :radio),
#      :q05 => Questionnaires.define_question("Ik geef mezelf overal de schuld van.", 
#                              :type => :radio),
#      :q06 => Questionnaires.define_question("Ik ben geirriteerd.",
#                              :type => :radio),
#      :q99 => Questionnaires.define_question("Blaat", 
#                              :type => :open)
#    }
#  end
#
#  def script
#    [ :q99, :q01, :q02, :q03, :q04, :q05, :q06 ]
#  end
#  
#end
