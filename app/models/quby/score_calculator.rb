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
    #           :age - The Integer age of the patient to be used in
    #                  score calculation (optional)
    #           :gender - The Symbol gender of the patient, must be one of:
    #                     :male, :female or :unknown (optional)
    def initialize(values, patient = {})
      @values = values
      @patient = patient
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
      keys = keys.map(&:to_s)

      if keys.empty?
        @values
      else
        keys.each do |key|
          raise "Key #{key.inspect} not found in values: #{@values.inspect}" unless @values.has_key?(key)
        end

        @values.values_at(*keys)
      end
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
      patient[:age]
    end

    # Public: Returns the Symbol describing the gender of the patient. 
    # 
    # The symbol :unknown is returned when gender is not known.
    def gender
      patient[:gender] || :unknown
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
