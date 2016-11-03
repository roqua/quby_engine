module Quby
  module Questionnaires
    class API
      def initialize(questionnaire_repo:)
        @repo = questionnaire_repo
        @cache = {}
      end

      def find(key)
        if fresh?(key)
          # print "HIT:#{key} "
          return @cache[key][:questionnaire]
          # else
          # print "MISS:#{key} "
        end

        definition = @repo.find key
        @cache[key] = {questionnaire: build_from_definition(definition), timestamp: definition.timestamp}
        @cache[key][:questionnaire]
      end

      def exists?(questionnaire_key)
        @repo.exists? questionnaire_key
      end

      def all
        @repo.keys.map { |key| find(key) }
      end

      def validate(key, sourcecode)
        definition = Entities::Definition.new(key: key, sourcecode: sourcecode)
        definition.valid?
        definition
      end

      private

      def build_from_definition(definition)
        ActiveSupport::Notifications.instrument('quby.questionaire.build') do
          DSL.build_from_definition(definition)
        end
      end

      def fresh?(key)
        return false unless @cache.key?(key)
        @cache[key][:timestamp].to_i == @repo.timestamp(key).to_i
      end
    end
  end
end
