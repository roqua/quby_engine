module Quby
  class AttributeCalculator
    attr_reader :hidden, :shown, :groups

    def initialize(questionnaire, answer)
      @hidden = []
      @shown  = []
      @groups = {}

      questionnaire.questions.each do |question|
        next unless question
        next if question.hidden?

        value = answer.send(question.key)

        if question.default_invisible && !@shown.include?(question.key)
          @hidden.push question.key
        end

        if value and [:radio, :scale].include?(question.type)
          question.options.each do |opt|
            if value.to_sym == opt.key
              if opt.hides_questions.present?
                @hidden.concat(opt.hides_questions.reject { |key| @shown.include? key }).uniq
              end
              if opt.shows_questions.present?
                @hidden.delete_if { |key| opt.shows_questions.include? key }
                @shown.concat(opt.shows_questions).uniq
              end
            end
          end
        end

        if question.question_group
          @groups[question.question_group] = [] unless @groups[question.question_group]
          @groups[question.question_group] << question.key
        end
      end
    end
  end
end
