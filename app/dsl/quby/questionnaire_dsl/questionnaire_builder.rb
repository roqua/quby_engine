module Quby
  module QuestionnaireDsl
    class QuestionnaireBuilder
      def initialize(target_instance)
        @questionnaire = target_instance
        @default_question_options = {}
      end

      def leave_page_alert(text)
        @questionnaire.leave_page_alert = text
      end

      def key(key)
        # @questionnaire.key = key
      end

      def title(title)
        @questionnaire.title = title
      end

      def description(description)
        @questionnaire.description = description
      end

      def outcome_description(description)
        @questionnaire.outcome_description = description
      end

      def short_description(description)
        @questionnaire.short_description = description
      end

      def abortable
        @questionnaire.abortable = true
      end

      def allow_hotkeys(type = :all)
        @questionnaire.allow_hotkeys = type
      end

      def enable_previous_questionnaire_button
        @questionnaire.enable_previous_questionnaire_button = true
      end

      def scroll_to_next_question
        @questionnaire.scroll_to_next_question = true
      end

      def css(value)
        @questionnaire.extra_css ||= ""
        @questionnaire.extra_css += value
      end

      def default_answer_value(value)
        @questionnaire.default_answer_value = value
      end

      def log_user_activity(value = true)
        @questionnaire.log_user_activity = value
      end
      
      def panel(title = nil, options = {}, &block)
        p = PanelBuilder.new(title, options.merge(default_panel_options))
        p.instance_eval(&block)

        @questionnaire.instance_eval do
          @panels ||= []
          @panels << p.build
        end
      end

      def default_question_options(options = {})
        @default_question_options.merge!(options)
      end

      # Short-circuit the question command to perform an implicit panel
      def question(key, options = {}, &block)
        panel(nil, default_panel_options) do
          question(key, default_question_options(options.merge({:questionnaire => @questionnaire})), &block)
        end
      end

      # Short-circuit the text command to perform an implicit panel
      def text(value, options = {})
        panel(nil, default_panel_options) do
          text(value, options)
        end
      end

      # Short-circuit the table command to perform an implicit panel
      def table(options = {}, &block)
        panel(nil, default_panel_options) do
          table(options, &block)
        end
      end

      # score :totaal do
      #   # Plain old Ruby code here, executed in the scope of the answer
      #   q01 + q02 + q03
      # end
      def score(key, options = {}, &block)
        s = ScoreBuilder.new(key, options, &block)

        @questionnaire.instance_eval do
          @scores ||= []
          @scores << s.build
        end
      end

      private
      def default_panel_options
        {:questionnaire => @questionnaire, :default_question_options => @default_question_options}
      end
    end

  end
end
