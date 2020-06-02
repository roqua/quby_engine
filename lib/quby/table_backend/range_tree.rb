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
    def initialize(headers, compare, data)
      @data = data
      @headers = headers
      @compare = compare
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
    #       -Infinity...10:
    #         39: 39
    #       10...20:
    #         42: 42
    #     11...12:
    #       -Infinity...10:
    #         40: 40
    #       10...20:
    #         43: 43
    #   female:
    #     10...11:
    #       etc. etc. etc.
    def tree
      @tree ||= @data.each_with_object({}) do |row, current_node|
        row.each_with_index do |v, idx|
          key =
            case @compare[idx]
            when 'string' then v.to_s
            when 'float' then parse_float(v)
            when 'range' then create_range(v)
            end

          if @headers[idx] == 'norm'
            current_node[key] = key
          else
            current_node[key] ||= {}
          end
          current_node = current_node[key]
        end
      end
    end

    # All parameters must be present to do a lookup but the order does not matter.
    def validate_parameters(parameters)
      if (@headers - ['norm']).sort != parameters.keys.map(&:to_s).sort
        fail 'Incompatible score parameters found'
      end
    end

    # Reduce the tree (a hash) to a normscore by looking up the correct values/ranges
    # for each column in @headers.
    # Returns a single normscore when found.
    # Returns nil and reports to AppSignal when normscore could not be found.
    def lookup_score(parameters)
      (@headers - ['norm']).each_with_index.reduce(tree) do |acc, (header, idx)|
        case @compare[idx]
        when 'string'
          acc[parameters[header.to_sym].to_s]
        when 'float'
          acc[parameters[header.to_sym].to_f]
        when 'range'
          acc.select { |k, _v| k.cover?(parameters[header.to_sym].to_f) }.values.first
        end
      end.values.first # normscore is a hash with a single element, get the value.
    rescue StandardError => exception
      # Normscore could not be found for the given parameters.
      if defined? Roqua::Support::Errors
        Roqua::Support::Errors.report(exception, parameters: parameters)
      end
      nil
    end

    def create_range(value)
      min, max = value.split(':').map { |val| parse_float(val) }
      fail 'Cannot create range between two equal values' if min == max
      (min...max)
    end

    def parse_float(value)
      case value
      when 'infinity'  then Float::INFINITY
      when 'minfinity' then -Float::INFINITY
      else Float(value)
      end
    end
  end
end
