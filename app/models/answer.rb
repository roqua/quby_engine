class Answer < ActiveRecord::Base
  belongs_to :questionnaire

  serialize :value
end
