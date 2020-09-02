# frozen_string_literal: true

# A lookup tree to find values by multiple arguments.
#
# Created by LookupTable from a csv file or by add_lookup_tree from dsl.
#
# Example tree:
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
#
# with levels:
# ['scale', 'gender', 'age', 'raw', 'norm']
#
# will allow a lookup like:
# lookup({age: 10, raw: 5, scale: 'Inhibitie', gender: 'male'})` => 39
#
# Keys in the tree will be matched by hash lookup of the parameter value with the following exeptions:
# floats: can be found by integer as well
# strings: can be found by symbol as well.
# enumerables: will find the first key for which `include?(param)` returns true.
module Quby::TableBackend
  class RangeTree
    # @param tree [Hash<>] hash of hashes leading from parameter values/ranges to a result.
    # @params levels [Array<String>] the argument name for each level of the tree.
    def initialize(levels:, tree:)
      @levels = levels
      @tree = tree
    end

    # load csv data into a tree.
    # each row is a path through the tree.
    # String and float types are used to make an exact match.
    # A range is always a range between two floats where the range is between
    # the low value (inclusive) and the high value (exclusive),
    # written as 4:5 (low:high). These boundaries can be given as floats or
    # integers, but internally they are always treated as a floats.
    # The low and high values of a range cannot be equal.
    # Use minfinity or infinity to create infinite ranges.
    #
    # @params levels [Array<String>] An array of column names
    # @param compare [Array<String>]An array of lookup types (string, float or range) for each column
    # @param data [Array<Array<>>] The rows describing a path through the tree.
    def self.from_csv(levels:, compare:, data:)
      tree = data.each_with_object({}) do |row, tree|
        add_to_tree(tree, row, levels, compare)
      end
      new(levels: levels, tree: tree)
    end


    # Given a parameters hash that contains a value or range for every
    # level in the tree, find and return the normscore.
    # ie. `lookup({age: 10, raw: 5, scale: 'Inhibitie', gender: 'male'})` => 39
    def lookup(parameters)
      validate_parameters(parameters)
      lookup_score(parameters)
    end

    private

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
          node[value.to_s] # from csv it's always a string, but should also allow symbol param.
        when Float
          node[value.to_f] # from csv it's always a float, but should also allow int param.
        when Enumerable
          node.find { |k, _v| k.include? value }.last
        else
          node[value]
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
