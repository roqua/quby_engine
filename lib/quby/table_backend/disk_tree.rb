# frozen_string_literal: true

require 'pathname'
require 'csv'

module Quby::TableBackend
  class DiskTree
    attr_reader :data, :headers, :compare

    def initialize(key)
      path = self.class.disk_table_root.join(key + '.csv')

      @data = CSV.read(path, col_sep: ',', skip_blanks: true)
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
            when 'exact' then v
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
      max > min ? (min...max) : (min..max)
    end

    def parse_value(value)
      case value
      when 'infinity'  then Float::INFINITY
      when 'minfinity' then -Float::INFINITY
      else value.to_i
      end
    end
  end
end
