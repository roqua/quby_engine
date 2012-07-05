module Quby
  class ScoreCalculator
    attr_accessor :values
    attr_accessor :patient

    # Evaluates block within the context of a new calculator
    # instance. All instance methods are accessible.
    def self.calculate(*args, &block)
      instance = self.new(*args)
      instance.instance_eval &block
    end

    # Public: Initialize a new ScoreCalculator
    #
    # values - The Hash values describes the keys of questions and the values
    #          of the answer given to that question.
    # patient - A Hash describing extra patient information (default: {})
    #           :birthyear - The Integer birthyear of the patient to be used in
    #                        score calculation (optional)
    #           :gender - The Symbol gender of the patient, must be one of:
    #                     :male, :female or :unknown (optional)
    def initialize(values, patient_attrs = {})
      @values = values
      @patient = ::Quby::Patient.new(patient_attrs)
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
        raise "Key #{key.inspect} not found in values: #{@values.inspect}" unless @values.has_key?(key)
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
      values.reduce(0, &:+).to_f / values.length
    end

    # Public: Gives mean of values, ignoring nil values
    #
    # values - An Array of Numerics
    #
    # Returns the mean of the given values
    def mean_ignoring_nils(values)
      mean(values.reject(&:blank?))
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
      values = values.map{|value| value ? value : mean}
      values.reduce(0, &:+)
    end

    # Public: Sums values, extrapolating nils to be valued as the mean of the present values
    #
    # values - An Array of Numerics
    #
    # Returns the sum of the given values, or nil if less than 80% is present
    def sum_extrapolate_80_pct(values)
      sum_extrapolate(values, values.length*0.8)
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
      patient.age
    end

    # Public: Returns the Symbol describing the gender of the patient.
    #
    # The symbol :unknown is returned when gender is not known.
    def gender
      patient.gender
    end

    def require_percentage_filled(values, percentage)
      percentage = percentage / 100.0 if percentage > 1
      selects = values.select {|i| not i.nil? }
      percentage_filled = selects.length.to_f / values.length.to_f
      raise "Needed at least #{percentage * 100}% answered, got #{percentage_filled * 100}%" unless percentage_filled >= percentage
      selects
    end
  end
end
