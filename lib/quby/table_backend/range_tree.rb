# frozen_string_literal: true

# Create a value lookup tree from a headers array, a compare (type) array and a data array of arrays.
# The #lookup method will try to find the data row where each of the comparison columns matches
# the given parameters and return the value from the norm column.
#
# #initialize params:
# headers: An array of column names
# compare: An array of lookup types (string, float or range) for each column
# data: An array of arrays containing the rows describing the mapping from the
#   different lookup columns to the `norm` value.
#
# The last column of the headers must be called 'norm' and
# must have the 'float' type (in compare array).
#
# String and float types are used to make an exact match.
# A range is always a range between two floats where the range is between
# the low value (inclusive) and the high value (exclusive),
# written as 4:5 (low:high). These boundaries can be given as floats or
# integers, but internally they are always treated as a floats.
# The low and high values of a range cannot be equal.
# Use minfinity or infinity to create infinite ranges.
module Quby::TableBackend
  class RangeTree
    def initialize(levels:, tree:)
      @levels = levels
      @tree = tree
    end

    def self.from_csv(levels:, compare:, data:)
      new(levels: levels, tree: tree(levels, compare, data))
    end


    # Given a parameters hash that contains a value or range for every
    # header, find and return the normscore.
    # ie. `lookup({age: 10, raw: 5, scale: 'Inhibitie', gender: 'male'})` => 39
    def lookup(parameters)
      validate_parameters(parameters)
      lookup_score(parameters)
    end

    private

    # Build a lookup tree (hash) from the csv input data.
    # Starting with the first column, it returns a hash with entries
    # for every value in the column. The value for such an entry
    # is a hash with all entries for the next column, etc. Example:
    # Inhibitie:
    #   male:
    #     10...11:
    #       -Infinity...10: 39
    #       10...20: 42
    #     11...12:
    #       -Infinity...10: 40
    #       10...20: : 43
    #   female:
    #     10...11: 38
    #     ...
    def self.tree(levels, compare, data)
      data.each_with_object({}) do |row, tree|
        add_to_tree(tree, row, levels, compare)
      end
    end

    def self.add_to_tree(tree, (value, *path), (level, *levels), (compare, *compares))
      key = case compare
            when 'string' then value.to_s
            when 'float' then parse_float(value)
            when 'range' then create_range(value)
            end

      if levels.empty?
        return key
      end

      tree.merge! key => add_to_tree(tree[key] || {}, path, levels, compares)
    end

    def self.create_range(value)
      min, max = value.split(':').map { |val| parse_float(val) }
      fail 'Cannot create range between two equal values' if min == max
      (min...max)
    end

    def self.parse_float(value)
      case value
      when 'infinity'  then Float::INFINITY
      when 'minfinity' then -Float::INFINITY
      else Float(value)
      end
    end

    # All parameters must be present to do a lookup but the order does not matter.
    def validate_parameters(parameters)
      if @levels[0...-1].sort != parameters.keys.map(&:to_s).sort
        fail 'Incompatible score parameters found'
      end
    end

    # Reduce the tree (a hash) to a normscore by looking up the correct values/ranges
    # for each column in @levels.
    # Returns a single normscore when found.
    # Returns nil and reports to AppSignal when normscore could not be found.
    def lookup_score(parameters)
      @levels[0...-1].reduce(@tree) do |node, level|
        value = parameters[level.to_sym]
        # binding.pry
        case node.first.first # all keys for one level are the same type.
        when String
          node[value.to_s]
        when Symbol
          node[value]
        when Float
          node[value.to_f]
        when Integer
          node[value]
        when Enumerable
          node.find { |k, _v| k.include? value }.last
        end
      end
    rescue StandardError => exception
      # Normscore could not be found for the given parameters.
      if defined? Roqua::Support::Errors
        Roqua::Support::Errors.report(exception, parameters: parameters)
      end
      nil
    end
  end
end
