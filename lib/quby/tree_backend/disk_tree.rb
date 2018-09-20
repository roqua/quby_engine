require 'pathname'
require 'csv'

module Quby::TreeBackend
  class DiskTree
    attr_reader :data, :headers, :compare

    def initialize(key)
      path = Pathname.new self.class.disk_table_root.join(key)

      @data = CSV.read(path, col_sep: ',', headers: :first_row,
                             skip_blanks: true, converters: [:integer])
      @headers = @data.headers
      @compare = Hash[@data.delete(0)]
    end

    def lookup(parameters)
      (@headers - ['norm']).reduce(tree) do |acc, header|
        case @compare[header]
        when 'exact'
          acc.select { |k, _v| k == parameters[header.to_sym] }.values.first
        when 'range'
          acc.select { |k, _v| k.cover?(parameters[header.to_sym]) }.values.first
        end
      end.values.first
    rescue StandardError
      'Not found'
    end

    def tree
      @tree ||= @data.by_row.each_with_object({}) do |row, current_node|
        row.each do |k, v|
          key =
            case @compare[k.to_s]
            when 'exact' then v
            when 'range' then create_range(v)
            end

          if k.to_s == 'norm'
            current_node[key] = v
          else
            current_node[key] = {} unless current_node[key]
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
