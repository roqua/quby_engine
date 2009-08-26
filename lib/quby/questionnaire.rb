module Quby
  class Questionnaire

    class << self
      def define(key, &block)
        qf = QuestionnaireFactory.new
        qf.instance_eval block
        return qf.generate_questionnaire
      end
    end

  end

  class QuestionnaireFactory
    def question(key, options)
      @questions << 
    end
  end

end
