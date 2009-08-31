module Quby
  module Questionnaires
    def self.define(key, options = {}, &block)
      qf = Quby::Factories::QuestionnaireFactory.new(key, options)
      qf.instance_eval(&block)
      return qf.build
    end
  end

  module Factories
    class QuestionnaireFactory
      attr_reader :key
      
      def initialize(key, options = {})
        @questionnaire = Questionnaire.new(key, options)
      end
      
      def build
        @questionnaire
      end
      
      def question(key, options = {}, &block)
        q = Quby::Factories::QuestionFactory.new(key, options)
        q.instance_eval(&block)
        @questionnaire.questions << q.build
      end
    end
    
    class QuestionFactory
      attr_reader :key
      attr_reader :title
      attr_reader :type
      
      def initialize(key, options = {})
        @question = Quby::Question.new(key, options)
      end

      def build
        @question
      end

      def title(value)
        @question.title = value
      end
      
      def description(value)
        @question.description = value
      end

      def option(key, options = {})
        @question.options << Quby::QuestionOption.new(key, options)
      end
    end

  end

end
