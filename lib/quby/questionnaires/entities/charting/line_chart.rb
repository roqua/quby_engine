# frozen_string_literal: true

require 'quby/questionnaires/entities/charting/chart'

module Quby
  module Questionnaires
    module Entities
      module Charting
        class LineChart < Chart
          # @return [String]
          attr_accessor :y_label

          # @return [Symbol]
          attr_accessor :tonality

          # @return [Proc]
          attr_accessor :baseline

          # @return [Float]
          attr_accessor :clinically_relevant_change

          def initialize(key, y_label: nil, tonality: :lower_is_better, baseline: nil, clinically_relevant_change: nil, **kwargs)
            super(key, **kwargs)
            self.y_label = y_label
            self.tonality = tonality
            self.baseline = baseline
            self.clinically_relevant_change = clinically_relevant_change
          end

          def baseline
            @baseline_proc ||= make_baseline_proc
          end

          def tonality=(value)
            fail "Invalid tonality: #{value}" unless [:higher_is_better, :lower_is_better].include?(value)
            @tonality = value
          end

          private

          def make_baseline_proc
            return unless @baseline

            case value
            when Hash
              ->(age, gender) {
                age_match = value.find { |age_range, _v| age && age_range === age }
                hash_by_gender = (age_match&.last || value.stringify_keys["default"])

                gender_match = hash_by_gender.find {|gender_key, _v| gender && gender_key.to_s == gender.to_s }
                gender_match&.last || hash_by_gender.stringify_keys['default']
              }
            else
              @chart.baseline = ->(age, gender) { value }
            end
          end
        end
      end
    end
  end
end
