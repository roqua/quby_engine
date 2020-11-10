# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class LineChart < Chart
          BaselineLookup = Types::Hash.map(
            Types::Range | Types::Coercible::Symbol, # age
            Types::Hash.map(
              Types::Gender,
              Types::Number
            )
          )

          attribute? :tonality, Types::Coercible::Symbol.default(:lower_is_better).enum(:higher_is_better, :lower_is_better)
          attribute? :y_label, Types::String.optional
          attribute? :baseline, BaselineLookup.optional

          attribute? :clinically_relevant_change, Types::Float.optional

          def baseline
            @baseline_proc ||= make_baseline_proc
          end

          private

          def make_baseline_proc
            return unless attributes[:baseline]

            case attributes[:baseline]
            when Hash
              ->(age, gender) {
                age_match = attributes[:baseline].find { |age_range, _v| age && age_range === age }
                hash_by_gender = (age_match&.last || attributes[:baseline].stringify_keys["default"])

                gender_match = hash_by_gender.find {|gender_key, _v| gender && gender_key.to_s == gender.to_s }
                gender_match&.last || hash_by_gender.stringify_keys['default']
              }
            else
              ->(age, gender) { @baseline }
            end
          end
        end
      end
    end
  end
end
