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
  end
end
