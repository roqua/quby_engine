# frozen_string_literal: true

require 'pathname'
require 'csv'

# Create a lookup tree from a csv file that converts raw scores
# to normalized scores.
# The csv file should have two header rows, one with the column
# names and one with the lookup types (exact or range).
# String types should always use the `exact` match type.
# Numerical types can use the `range` type where the range is between
# the low value (inclusive) and the high value (exclusive).
# The low and high values of a range cannot be equal.
# Use minfinity or infinity to create infinite ranges.
module Quby::TableBackend
  class DiskTree
    attr_reader :data, :headers, :compare

    def initialize(key)
      path = self.class.disk_table_root.join(key + '.csv')

      @data = CSV.read(path, col_sep: ';', skip_blanks: true)
      @headers = @data.shift
      @compare = @data.shift
    end

    def lookup(parameters)
      validate_parameters(parameters)
      lookup_score(parameters)
    end

    def tree
      @tree ||= @data.each_with_object({}) do |row, current_node|
        row.each_with_index do |v, idx|
          key =
            case @compare[idx]
            when 'exact' then parse_value(v)
            when 'range' then create_range(v)
            end

          if @headers[idx] == 'norm'
            current_node[key] = v
          else
            current_node[key] ||= {}
          end
          current_node = current_node[key]
        end
      end
    end

    def self.disk_table_root
      fail 'Quby.lookup_table_path not configured' if Quby.lookup_table_path.blank?
      Pathname.new(Quby.lookup_table_path)
    end

    private

    def validate_parameters(parameters)
      if (@headers - ['norm']).sort != parameters.keys.map(&:to_s).sort
        fail 'Incompatible score parameters found'
      end
    end

    def lookup_score(parameters)
      (@headers - ['norm']).reduce(tree) do |acc, header|
        idx = @headers.find_index(header)
        case @compare[idx]
        when 'exact'
          acc[parameters[header.to_sym]]
        when 'range'
          acc.select { |k, _v| k.cover?(parameters[header.to_sym].to_i) }.values.first
        end
      end.values.first.to_i
    rescue StandardError => exception
      if defined? Roqua::Support::Errors
        Roqua::Support::Errors.report(exception, parameters: parameters)
      end
      nil
    end

    def create_range(value)
      min, max = value.split(':').map { |val| parse_value(val) }
      fail 'Cannot create range between two equal values' if min == max
      (min...max)
    end

    def parse_value(value)
      case value
      when 'infinity'  then Float::INFINITY
      when 'minfinity' then -Float::INFINITY
      else Integer(value)
      end
    rescue ArgumentError
      # Not an integer
      value
    end
  end
end
