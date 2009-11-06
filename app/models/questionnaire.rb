class Questionnaire < ActiveRecord::Base
  has_many :answers
  
  cattr_accessor :questions
 
  serialize :value
end
