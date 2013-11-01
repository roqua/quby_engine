module Quby
  module AnswerDsl
    def self.enhance(target_instance)
      answer = target_instance
      questionnaire = target_instance.questionnaire

      answer.dsl_last_update = questionnaire.last_update

      answer.class_eval do
        questionnaire.questions.each do |question|
          next if question.andand.key.blank?
          case question.type
          when :date

            define_method(question.year_key) do
              self.value ||= Hash.new
              self.value[question.year_key]
            end

            define_method("#{question.year_key}=") do |v|
              self.value ||= Hash.new
              self.value[question.year_key] = v
            end

            define_method(question.month_key) do
              self.value ||= Hash.new
              self.value[question.month_key]
            end

            define_method("#{question.month_key}=") do |v|
              self.value ||= Hash.new
              self.value[question.month_key] = v
            end

            define_method(question.day_key) do
              self.value ||= Hash.new
              self.value[question.day_key]
            end

            define_method("#{question.day_key}=") do |v|
              self.value ||= Hash.new
              self.value[question.day_key] = v
            end

            define_method(question.key) do
              self.value ||= Hash.new
              v = [self.value[question.day_key.to_s   || "#{question.key}_dd"],
                   self.value[question.month_key.to_s || "#{question.key}_mm"],
                   self.value[question.year_key.to_s  || "#{question.key}_yyyy"]]
              if v.reduce(true) { |allblank, it| it.blank? and allblank }
                return ""
              else
                return v.join("-")
              end
            end

          when :check_box

            define_method(question.key) do
              self.value ||= Hash.new
              self.value[question.key.to_s] ||= Hash.new
            end

            question.options.each do |opt|
              next if opt.andand.key.blank?
              define_method("#{opt.key}") do
                self.value ||= Hash.new
                self.value[question.key.to_s] ||= Hash.new
                self.value[opt.key.to_s] ||= 0
              end

              define_method("#{opt.key}=") do |v|
                v = v.to_i
                self.value ||= Hash.new
                self.value[question.key.to_s] ||= Hash.new
                self.value[question.key.to_s][opt.key.to_s] = v
                self.value[opt.key.to_s] = v
              end
            end
          else
            # Includes:
            #question.type == :radio
            #question.type == :scale
            #question.type == :select
            #question.type == :string
            #question.type == :textarea
            #question.type == :integer
            #question.type == :float

            if [:radio, :scale, :select].include? question.type #getters for individual question options
              question.options.each do |opt|
                define_method("#{question.key}_#{opt.key}") do
                  self.value ||= Hash.new
                  self.value[question.key.to_s] == opt.key.to_s
                end
              end
            end

            define_method(question.key) do
              self.value ||= Hash.new
              self.value[question.key.to_s]
            end

            define_method(question.key.to_s + "=") do |v|
              self.value ||= Hash.new
              self.value[question.key.to_s] = v
            end
          end rescue nil
        end

        if questionnaire.scores
          questionnaire.scores.each do |score|
            scorer = score.calculation
            define_method("score_" + score.key.to_s, &scorer)
          end
        end
      end
    end
  end
end
