require 'set'

module Quby
  module Questionnaires
    module Entities
      class Fields
        attr_reader :fields, :input_keys, :answer_keys

        def initialize
          @fields      = {}
          @input_keys  = Set.new
          @answer_keys = Set.new
        end

        def add(question)
          new_input_keys  = Set.new(question.input_keys)
          new_answer_keys = Set.new(question.answer_keys)

          if @input_keys.intersect?(new_input_keys)
            fail "Duplicate input keys: #{@input_keys.intersection(new_input_keys)}"
          end

          if @answer_keys.intersect?(new_answer_keys)
            fail "Duplicate answer keys: #{@answer_keys.intersection(new_answer_keys)}"
          end

          @fields[question.key.to_s] = question
          @input_keys.merge(new_input_keys)
          @answer_keys.merge(new_answer_keys)
        end

        def question_key?(key)
          @fields.key?(key)
        end

        def input_key?(key)
          @input_keys.include?(key)
        end
      end
    end
  end
end
