module Quby
  module Questionnaires
    class API
      def initialize(questionnaire_repo:)
        @repo = questionnaire_repo
        @cache = {}
      end

      def find(key)
        return @cache[key][:questionnaire] if fresh?(key)
        definition = @repo.find key
        @cache[key] = {questionnaire: DSL.build_from_definition(definition), timestamp: definition.timestamp}
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

      def fresh?(key)
        return false unless @cache.key?(key)
        @cache[key][:timestamp].to_i == @repo.timestamp(key)
      end
    end
  end
end
