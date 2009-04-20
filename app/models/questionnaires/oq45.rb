# -*- coding: utf-8 -*-
#Quby::Questionnaires.define :oq45 do
#
#  questions :type => :radio,
#            :options => [0,1,2,3,4] do
#    question :q01 do
#      title "Ik kan goed met anderen overweg."
#      description "...."
#      help ".............."
#      after_answer do
#        jump_to :q04 if answer < 2
#      end
#    end
#    question :q02, "Ik word gauw moe."
#    question :q03, "Ik ben nergens in geïnteresseerd."
#    question :q04, "Ik sta onder stress op het werk/op school."
#    question :q05, "Ik geef mezelf overal de schuld van."
#    question :q06, "Ik ben geïrriteerd."
#  end
#
#end

module Questionnaires
  class Oq45
  
    def questions
      {
        :q01 => Question.new("Ik kan goed met anderen overweg."),
        :q02 => Question.new("Ik word gauw moe."),
        :q03 => Question.new("Ik ben nergens in geïnteresseerd."),
        :q04 => Question.new("Ik sta onder stress op het werk/op school."),
        :q05 => Question.new("Ik geef mezelf overal de schuld van."),
        :q06 => Question.new("Ik ben geïrriteerd."),
        :q99 => Question.new("Blaat")
      }
    end

    def script
      [ :q99, :q01, :q02, :q03, :q04, :q05, :q06 ]
    end
    
  end
end
