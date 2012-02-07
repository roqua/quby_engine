module Quby
  class ScoreCalculator
    attr_accessor :values

    # Evaluates block within the context of a new calculator
    # instance. All instance methods are accessible.
    def self.calculate(options = {}, &block)
      instance = self.new(options)
      instance.instance_eval &block
    end

    def initialize(options = {})
      @values = options[:values]
      @score = {}
    end

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

    def sum(values)
      values.reduce(0, &:+)
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
