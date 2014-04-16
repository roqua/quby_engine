module Quby
  class ScoreCalculator
    # Evaluates block within the context of a new calculator
    # instance. All instance methods are accessible.
    def self.calculate(*args, &block)
      instance = new(*args)
      instance.instance_eval(&block)
    end

    # Public: Initialize a new ScoreCalculator
    #
    # values - The Hash values describes the keys of questions and the values
    #          of the answer given to that question.
    # timestamp - The Time to be used to calculate the age of the patient.
    # patient - A Hash describing extra patient information (default: {})
    #           :birthyear - The Integer birthyear of the patient to be used in
    #                        score calculation (optional)
    #           :gender - The Symbol gender of the patient, must be one of:
    #                     :male, :female or :unknown (optional)
    # scores - The Hash containing other scores calculated for the answer, so
    #          that these scores can be accessed from the current calculation.
    def initialize(values, timestamp, patient_attrs = {}, scores = {})
      @values = values
      @timestamp = timestamp
      @patient = ::Quby::Patient.new(patient_attrs)
      @scores = scores.with_indifferent_access
      @score = {}
    end

    # Public: Get values for given question keys
    #
    # *keys - A list of keys for which to return values
    #
    # Returns an Array of values. Values are whatever they may be defined as,
    # usually they are either Integers of Floats, but remember that no such
    # restriction is placed. And for open questions the value will probably
    # be a String.
    def values(*keys)
      keys.map(&:to_s).each do |key|
        fail "Key #{key.inspect} not found in values: #{@values.inspect}" unless @values.key?(key)
      end
      values_with_nils(*keys)
    end

    # Public: Get values for given question keys, or nil if the question is not filled in
    #
    # *keys - A list of keys for which to return values
    #
    # Returns an Array of values. Values are whatever they may be defined as,
    # usually they are either Integers of Floats, but remember that no such
    # restriction is placed. And for open questions the value will probably
    # be a String. If the question is not filled in or the question key is
    # unknown, nil will be returned for that question.
    def values_with_nils(*keys)
      keys = keys.map(&:to_s)
      fail ArgumentError, 'Key requested more than once' if keys.uniq!

      if keys.empty?
        @values
      else
        @values.values_at(*keys)
      end
    end

    # Public: Gives mean of values
    #
    # values - An Array of Numerics
    #
    # Returns the mean of the given values
    def mean(values)
      return 0.0 if values.length == 0
      sum(values).to_f / values.length
    end

    # Public: Gives mean of values, ignoring nil values
    #
    # values - An Array of Numerics
    #
    # Returns the mean of the given values
    def mean_ignoring_nils(values)
      compacted_values = values.reject(&:blank?)
      return nil if compacted_values.length == 0
      mean(compacted_values)
    end

    # Public: Gives mean of values, ignoring nil values if >= 80% is filled in
    #
    # values - An Array of Numerics
    #
    # Returns the mean of the given values, or nil if less than 80% is present
    def mean_ignoring_nils_80_pct(values)
      compacted_values = values.reject(&:blank?)
      return nil if compacted_values.length == 0
      return nil if compacted_values.length < values.length * 0.8
      mean(compacted_values)
    end

    # Public: Sums values, extrapolating nils to be valued as the mean of the present values
    #
    # values - An Array of Numerics
    # minimum_answered - The minimum of values needed to be present, returns nil otherwise
    #
    # Returns the sum of the given values, or nil if minimum_present is not met
    def sum_extrapolate(values, minimum_present)
      return nil if values.reject(&:blank?).length < minimum_present
      mean = mean_ignoring_nils(values)
      values = values.map { |value| value ? value : mean }
      sum(values)
    end

    # Public: Sums values, extrapolating nils to be valued as the mean of the present values
    #
    # values - An Array of Numerics
    #
    # Returns the sum of the given values, or nil if less than 80% is present
    def sum_extrapolate_80_pct(values)
      sum_extrapolate(values, values.length * 0.8)
    end

    # Public: Sums values
    #
    # values - An Array of Numerics
    #
    # Returns the sum of the given values
    def sum(values)
      values.reduce(0, &:+)
    end

    # Public: Returns the Integer age of the patient, or nil if it's not known.
    def age
      @patient.age_at @timestamp
    end

    # Public: Returns the Symbol describing the gender of the patient.
    #
    # The symbol :unknown is returned when gender is not known.
    def gender
      @patient.gender
    end

    # Public: Returns the Hash emitted by another score calculation
    #
    # key - The Symbol of another score.
    def score(key)
      fail "Score #{key.inspect} does not exist or is not calculated yet." unless @scores.key? key
      @scores.fetch(key)
    end

    def require_percentage_filled(values, percentage)
      percentage /= 100.0 if percentage > 1
      selects = values.select { |i| !i.nil? }
      percentage_filled = selects.length.to_f / values.length.to_f

      unless percentage_filled >= percentage
        fail "Needed at least #{percentage * 100}% answered, got #{percentage_filled * 100}%"
      end

      selects
    end
  end
end
