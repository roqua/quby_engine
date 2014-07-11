require 'set'

module Quby
  module Questionnaires
    module Entities
      class Fields
        attr_reader :question_hash

        # An +answer_key+ is a key that will exist in the values hash of an answer. This means that answer keys for
        # radio's will be just the question key, and answer keys for checkboxes will be the keys of all the options.
        # These are the POST parameters when submitting the form, an so they must be globally unique or we won't know
        # which question the received data belongs to.
        attr_reader :answer_keys

        # An +input_key+ is a key that uniquely identifies a single <input> tag. For radio's, every radio option will
        # have it's own input key. This is needed because option keys must be globally unique so that they can be
        # targeted by :depends_on relations.
        attr_reader :input_keys

        def initialize
          @question_hash = {}
          @answer_keys   = Set.new
          @input_keys    = Set.new
        end

        def add(question)
          new_answer_keys = Set.new(question.answer_keys)
          new_input_keys  = Set.new(question.input_keys)

          if @answer_keys.intersect?(new_answer_keys)
            fail "Duplicate answer keys: #{@answer_keys.intersection(new_answer_keys)}"
          end

          if @input_keys.intersect?(new_input_keys)
            fail "Duplicate input keys: #{@input_keys.intersection(new_input_keys)}"
          end

          @question_hash[question.key] = question
          @input_keys.merge(new_input_keys)
          @answer_keys.merge(new_answer_keys)
        end

        def key_in_use?(key)
          @question_hash.key?(key) || @input_keys.include?(key)
        end

        # Given a list of question and option keys returns a list of input-keys. If a given key is a question-key,
        # adds the question.input_keys If a given key is an option-input-key it adds the given key. Raises an error
        # if a key is not defined.
        def expand_input_keys(keys)
          keys.reduce([]) do |ikeys, key|
            if question_hash.key?(key)
              ikeys += question_hash[key].input_keys
            elsif input_keys.include? key
              ikeys << key
            else
              fail UnknownInputKey, "Unknown input key #{key}"
            end
          end
        end
      end
    end
  end
end
